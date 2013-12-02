require 'spec_helper'

describe "LinkTests" do
  describe "GET /machine_toolx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "MachineToolx::MachineTool.where(:decommissioned => false).order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'machine_toolx_machine_tools', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      
            
      @cate = FactoryGirl.create(:commonx_misc_definition, :for_which => 'equipment_category', :active => true) 
      @stat = FactoryGirl.create(:commonx_misc_definition, :for_which => 'equipment_status', :active => true)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
      
    end
    it "works! (now write some real specs)" do
      equip = FactoryGirl.create(:machine_toolx_machine_tool, :category_id => @cate.id, :status_id => @stat.id, :last_updated_by_id => @u.id )
      visit machine_tools_path
      #save_and_open_page
      page.should have_content('Machine Tools')
      click_link "Edit"
      #save_and_open_page
      page.should have_content('Update Machine Tool')
      visit machine_tools_path
      click_link equip.id.to_s
      page.should have_content('Machine Tool Info')
      
      visit machine_tools_path
      #save_and_open_page
      click_link 'New Machine Tool'
      #save_and_open_page
      page.should have_content('New Machine Tool')
    end
  end
end
