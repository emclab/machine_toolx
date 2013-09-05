require 'spec_helper'

module MachineToolx
  describe MachineTool do
    it "should be OK" do
      c = FactoryGirl.build(:machine_toolx_machine_tool)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:machine_toolx_machine_tool, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:machine_toolx_machine_tool, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject dup name" do
      c = FactoryGirl.create(:machine_toolx_machine_tool, :name => 'short')
      c1 = FactoryGirl.build(:machine_toolx_machine_tool, :name => 'Short')
      c1.should_not be_valid
    end
    
    it "should reject nil model_num" do
      c = FactoryGirl.build(:machine_toolx_machine_tool, :model_num => nil)
      c.should_not be_valid
    end
    
    it "should reject nil status_id" do
      c = FactoryGirl.build(:machine_toolx_machine_tool, :status_id => nil)
      c.should_not be_valid
    end
    
    it "should reject nil category_id" do
      c = FactoryGirl.build(:machine_toolx_machine_tool, :category_id => nil)
      c.should_not be_valid
    end
    
    it "should reject dup serial_num" do
      c = FactoryGirl.create(:machine_toolx_machine_tool, :serial_num => 'short')
      c1 = FactoryGirl.build(:machine_toolx_machine_tool, :serial_num => 'Short')
      c1.should_not be_valid
    end
    
    it "should allow dup serial num for different model_num" do
      c = FactoryGirl.create(:machine_toolx_machine_tool, :serial_num => 'short')
      c1 = FactoryGirl.build(:machine_toolx_machine_tool, :serial_num => 'Short', :model_num => 'new model', :name => 'a new one')
      c1.should be_valid
    end
    
  end
end
