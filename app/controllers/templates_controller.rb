class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @templates = current_store.templates.page(params[:page])
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
    @event_type = @template.event_type
    @event = @template.event
  end

  # POST /templates
  def create
    @template = current_store.templates.build(template_params)
    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_path, success: 'Template was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /templates/1
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to templates_path, success: 'Template was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /templates/1
  def destroy
    if @template.destroy
      respond_to do |format|
        format.html { redirect_to templates_path, success: 'Template was successfully destroyed.' }
      end
    else
      flash[:error] = @template.errors.full_messages
      redirect_to templates_path
    end
  end

  def list_event_types
    @event = Event.find(params[:event])
    @event_types = @event.event_types if @event
    template = Template.find(params[:template_id]) if  params[:template_id].present?
    if template.present?
      @event_type = template.event_type
    else
      @event_type = EventType.first
    end
    respond_to do |format|
      format.js
    end
  end

  def toggle_active
    template = Template.find(params[:id])
    unless template.active?
      current_active_template = Template.find_by(active: true, event_type_id: template.event_type_id, event_id: template.event_id)
      current_active_template.update_attributes(active: false) if current_active_template.present?
      template.update_attributes(active: true)
      flash[:success] = "Active Template changed successfully"
    else
      flash[:danger] = "Unable to deactivate this template."
    end
    @templates = current_store.templates.page(params[:page])
    redirect_to templates_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.fetch(:template, {}).permit(:email_type_id, :subject, :body, :event_id, :event_type_id, :active, :name)
    end
end
