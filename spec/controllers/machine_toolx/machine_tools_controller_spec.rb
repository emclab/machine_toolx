require 'spec_helper'

module MachineToolx
  describe MachineToolsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      
    end
    
    before(:each) do
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
        
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all machine tools" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "MachineToolx::MachineTool.where(:decommissioned => false).order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        equip1 = FactoryGirl.create(:machine_toolx_machine_tool, :name => 'new stuff', :serial_num => 'new serial')
        get 'index', {:use_route => :machine_toolx}
        assigns(:machine_tools).should =~ [equip, equip1]
      end
    end
  
    describe "GET 'new'" do
      it "should display the new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :machine_toolx}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "should create a new record" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.attributes_for(:machine_toolx_machine_tool)
        get 'create', {:use_route => :machine_toolx, :machine_tool => equip}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.attributes_for(:machine_toolx_machine_tool, :name => '')
        get 'create', {:use_route => :machine_toolx, :machine_tool => equip}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns render edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        get 'edit', {:use_route => :machine_toolx, :id => equip.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "returns updated page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        get 'update', {:use_route => :machine_toolx, :id => equip.id, :machine_tool => {:tech_spec => 'a new name'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        equip = FactoryGirl.create(:machine_toolx_machine_tool)
        get 'update', {:use_route => :machine_toolx, :id => equip.id, :machine_tool => {:model_num => ''}}
        response.should render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        cate = FactoryGirl.create(:commonx_misc_definition, :for_which => 'equipment_category')
        status = FactoryGirl.create(:commonx_misc_definition, :for_which => 'equipment_status')
        equip = FactoryGirl.create(:machine_toolx_machine_tool, :category_id => cate.id, :status_id => status.id, :last_updated_by_id => @u.id)
        get 'show', {:use_route => :machine_toolx, :id => equip.id}
        response.should be_success
      end
    end
  
  end
end
