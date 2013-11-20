module MachineToolx
  class MachineTool < ActiveRecord::Base
    attr_accessor :last_updated_by_name, :operator_name, :status_name
    attr_accessible :accessory, :decommissioned, :coolant, :dimension, :last_updated_by_id, :lubricant, :main_power_w, :mfg_date, :mfr, :model_num, :name, 
                    :operator_id, :tech_spec, :precision, :purchase_date, :rpm, :serial_num, :status_id, :tool, :category_id, :voltage, 
                    :weight_kg, :work_piece, :note, :op_cost_hourly,
                    :as => :role_new
    attr_accessible :accessory, :decommissioned, :coolant, :dimension, :last_updated_by_id, :lubricant, :main_power_w, :mfg_date, :mfr, :model_num, :name, 
                    :operator_id, :tech_spec, :precision, :purchase_date, :rpm, :serial_num, :status_id, :tool, :category_id, :voltage, 
                    :weight_kg, :work_piece, :note, :op_cost_hourly,
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :status, :class_name => 'Commonx::MiscDefinition' 
    belongs_to :operator, :class_name => 'Authentify::User' 
    has_many :maint_requests, :class_name => 'MaintRecordx::MaintRequest'
    
    validates_presence_of :model_num, :status_id, :category_id 
    validates :name, :presence => true, 
                     :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Name!')}             
    validates :serial_num, :uniqueness => {:scope => :model_num, :case_sensitive => false, :message => I18n.t('Duplicate Serial#!')}
  end
end
