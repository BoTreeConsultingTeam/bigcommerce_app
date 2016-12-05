class OmniauthsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    unless auth && auth[:extra][:raw_info][:context]
      return render_error("[install] Invalid credentials: #{JSON.pretty_generate(auth[:extra])}")
    end

    email = auth[:info][:email]
    name = auth[:info][:name]
    store_hash = auth[:extra][:context].split('/')[1]
    token = auth[:credentials][:token].token
    scope = auth[:extra][:scopes]

    # Lookup store
    store = Store.where(store_hash: store_hash).first
    if store
      logger.info "[install] Updating token for store '#{store_hash}' with scope '#{scope}'"
      store.update(access_token: token, scope: scope)
      # user = store.admin_user
    else
      # Create store record
      logger.info "[install] Installing app for store '#{store_hash}' with admin '#{email}'"
      store = Store.create(store_hash: store_hash, access_token: token, scope: scope, user_email: email, username: name)
      session[:store_id] = store.id
    end
    render 'home/index', status: 200
  end

  def load
    Rails.logger.debug ">>>>>>>>>>>>>>>> Started"
    payload = parse_signed_payload

    puts "Payload >>>> #{payload}"
    return render_error('[load] Invalid payload signature!') unless payload
    email = payload[:user][:email]
    puts "payload email>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{email}"
    store_hash = payload[:store_hash]
    puts "store hash #{store_hash}"
    # Lookup store
    @store = Store.first(store_hash: store_hash)
    puts "store #{@store.inspect}"
    return render_error("[load] Store not found!") unless @store


    # Login and redirect to home page
    logger.info "[load] Loading app for user '#{email}' on store '#{store_hash}'"
    session[:store_id] = @store.id
  end

  private

  def parse_signed_payload
    puts "request started "
    puts "#{params} <<<<<<<<<<<<<<<<<<<<<<<<< Params"
    signed_payload = params[:signed_payload]

    message_parts = signed_payload.split('.')
    puts "#{message_parts} <<<<<<<<<<<<<<<<<<<<<<<< Message parts"

    encoded_json_payload = message_parts[0]
    puts "Encoded json payload >>>>>>>>>>>>>>>>>>>>>>> #{encoded_json_payload}"
    encoded_hmac_signature = message_parts[1]
    puts "Encoded hmac signature #{encoded_hmac_signature}"
    payload = Base64.decode64(encoded_json_payload)
    puts "#{payload} <<<<<<<<<<<<<<<<<<<< PAYLOAd"
    provided_signature = Base64.decode64(encoded_hmac_signature)
    puts "provided_signature ><>>>>>>>>>>>>>>>>>>>>> #{provided_signature}"
    expected_signature = sign_payload(bc_client_secret, payload)
    puts "expected_signature >>>>>>>>>>>>>>> #{expected_signature}"

    if secure_compare(expected_signature, provided_signature)
      puts "going inside"
      return JSON.parse(payload, symbolize_names: true)
    end

    nil
  end

  def sign_payload(secret, payload)
    OpenSSL::HMAC::hexdigest('sha256', secret, payload)
  end

  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end

  def render_error(e)
    logger.warn "ERROR: #{e}"
    @error = e

    raise e
  end

  def bc_client_id
    ENV['BC_CLIENT_ID']
  end

  # Get client secret from env
  def bc_client_secret
    ENV['BC_CLIENT_SECRET']
  end

# Get the API url from env
  def bc_api_url
    ENV['BC_API_ENDPOINT'] || 'https://api.bigcommerce.com'
  end

  # Full url to this app
  def app_url
    ENV['APP_URL']
  end

  # The scopes we are requesting (must match what is requested in
  # Developer Portal).
  def scopes
    ENV.fetch('SCOPES', 'store_v2_products')
  end
end
