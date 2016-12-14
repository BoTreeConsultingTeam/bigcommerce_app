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
    new_template_params = template_params
    new_template_params['body'] = (template_params['body'] == '<br>') ? '' : template_params['body']
    @template = current_store.templates.build(new_template_params)
    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_path, success: 'Template was successfully created.' }
      else
        flash.now[:danger] = @template.errors.full_messages
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /templates/1
  def update
    new_template_params = template_params
    new_template_params['body'] = (template_params['body'] == '<br>') ? '' : template_params['body']
    if @template.active?
      if @template.event_type_id != template_params['event_type_id'].to_i || @template.event_id != template_params['event_id'].to_i
        @event_type = @template.event_type
        flash.now[:danger] = "You can't change event or event type of an active template. Please make anyother template as active first."
        render :edit and return
      else
        if @template.update_attributes(new_template_params)
          redirect_to templates_path, success: 'Template was successfully updated.' and return
        else
          @event_type = EventType.new
          flash.now[:danger] = @template.errors.full_messages
          render :edit and return
        end
      end
    else
      if @template.update_attributes(new_template_params)
        redirect_to templates_path, success: 'Template was successfully updated.'
      else
        @event_type = EventType.new
        flash.now[:danger] = @template.errors.full_messages
        render :edit
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
      flash.now[:danger] = @template.errors.full_messages
      redirect_to templates_path
    end
  end

  def list_event_types
    @event = Event.find(params[:event])
    @event_types = @event.event_types if @event
    template = Template.find(params[:template_id]) if  params[:template_id].present?
    if template.present?
      @event_type = EventType.new
    else
      @event_type = EventType.new
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
      flash[:danger] = "At least one email template should be active at a time for each event and event type."
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
