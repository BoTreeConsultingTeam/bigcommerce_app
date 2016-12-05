require 'pry'
class OmniauthsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    unless auth && auth[:extra][:raw_info][:context]
      return render_error("[install] Invalid credentials: #{JSON.pretty_generate(auth[:extra])}")
    end

    email = auth[:info][:email]
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
      store = Store.create(store_hash: store_hash, access_token: token, scope: scope)
    end
    redirect_to root_path
  end

  def load
    payload = parse_signed_payload
    return render_error('[load] Invalid payload signature!') unless payload

    email = payload[:user][:email]
    store_hash = payload[:store_hash]

    # Lookup store
    store = Store.first(store_hash: store_hash)
    return render_error("[load] Store not found!") unless store

    logger.info "[load] Loading app for user '#{email}' on store '#{store_hash}'"
    session[:store_id] = store.id
    session[:user_id] = user.id
    redirect '/'
  end

  private

  def parse_signed_payload
    signed_payload = params[:signed_payload]
    message_parts = signed_payload.split('.')

    encoded_json_payload = message_parts[0]
    encoded_hmac_signature = message_parts[1]

    payload = Base64.decode64(encoded_json_payload)
    provided_signature = Base64.decode64(encoded_hmac_signature)

    expected_signature = sign_payload(bc_client_secret, payload)

    if secure_compare(expected_signature, provided_signature)
      return JSON.parse(payload, symbolize_names: true)
    end
    nil
  end
end
