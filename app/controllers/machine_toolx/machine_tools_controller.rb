require_dependency "machine_toolx/application_controller"

module MachineToolx
  class MachineToolsController < ApplicationController
    before_filter :require_employee
    
    def index
      @title = t('Machine Tools')
      @machine_tools = params[:machine_toolx_machine_tools][:model_ar_r].page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('machine_tool_index_view', 'machine_toolx')
    end
  
    def new
      @title = t('New Machine Tool')
      @machine_tool = MachineToolx::MachineTool.new()
      @erb_code = find_config_const('machine_tool_new_view', 'machine_toolx')
    end
  
    def create
      @machine_tool = MachineToolx::MachineTool.new(params[:machine_tool], :as => :role_new)
      @machine_tool.last_updated_by_id = session[:user_id]
      if @machine_tool.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @erb_code = find_config_const('machine_tool_new_view', 'machine_toolx')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Machine Tool')
      @machine_tool = MachineToolx::MachineTool.find_by_id(params[:id])
      @erb_code = find_config_const('machine_tool_edit_view', 'machine_toolx')
    end
  
    def update
      @machine_tool = MachineToolx::MachineTool.find_by_id(params[:id])
      @machine_tool.last_updated_by_id = session[:user_id]
      if @machine_tool.update_attributes(params[:machine_tool], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('machine_tool_edit_view', 'machine_toolx')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Show Machine Tool')
      @machine_tool = MachineToolx::MachineTool.find_by_id(params[:id])
      @erb_code = find_config_const('machine_tool_show_view', 'machine_toolx')
    end
  end
end
