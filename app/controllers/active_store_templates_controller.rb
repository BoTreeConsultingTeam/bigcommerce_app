class ActiveStoreTemplatesController < ApplicationController
  before_action :set_active_store_template, only: [:show, :edit, :update, :destroy]

  # GET /active_store_templates
  def index
    @active_store_templates = ActiveStoreTemplate.all
  end

  # GET /active_store_templates/1
  def show
  end

  # GET /active_store_templates/new
  def new
    @active_store_template = ActiveStoreTemplate.new
  end

  # GET /active_store_templates/1/edit
  def edit
  end

  # POST /active_store_templates
  def create
    binding.pry
    @active_store_template = current_store.set_active_template(active_store_template_params)

    respond_to do |format|
      if @active_store_template.save
        format.html { redirect_to active_store_templates_url, notice: 'Active store template was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /active_store_templates/1
  def update
    respond_to do |format|
      if @active_store_template.update(active_store_template_params)
        format.html { redirect_to active_store_templates_url, notice: 'Active store template was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /active_store_templates/1
  def destroy
    @active_store_template.destroy
    respond_to do |format|
      format.html { redirect_to active_store_templates_url, notice: 'Active store template was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_store_template
      @active_store_template = ActiveStoreTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_store_template_params
      params.fetch(:active_store_template, {}).permit(:email_type_id, :template_id)
    end
end
