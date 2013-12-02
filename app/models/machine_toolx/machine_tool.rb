module MachineToolx
  class MachineTool < ActiveRecord::Base
    attr_accessor :last_updated_by_name, :operator_name, :status_name, :decommissioned_noupdate, :category_name, :mfg_date_noupdate, :purchase_date_noupdate
    attr_accessible :accessory, :decommissioned, :coolant, :dimension, :last_updated_by_id, :lubricant, :main_power_w, :mfg_date, :mfr, :model_num, :name, 
                    :operator_id, :tech_spec, :precision, :purchase_date, :rpm, :serial_num, :status_id, :tool, :category_id, :voltage, 
                    :weight_kg, :work_piece, :note, :op_cost_hourly,
                    :as => :role_new
    attr_accessible :accessory, :decommissioned, :coolant, :dimension, :last_updated_by_id, :lubricant, :main_power_w, :mfg_date, :mfr, :model_num, :name, 
                    :operator_id, :tech_spec, :precision, :purchase_date, :rpm, :serial_num, :status_id, :tool, :category_id, :voltage, 
                    :weight_kg, :work_piece, :note, :op_cost_hourly,
                    :decommissioned_noupdate, :last_updated_by_name, :operator_name, :status_name, :category_name, :mfg_date_noupdate, :purchase_date_noupdate,
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :status, :class_name => 'Commonx::MiscDefinition' 
    belongs_to :operator, :class_name => 'Authentify::User' 
    has_many :maint_requests, :class_name => 'MaintRecordx::MaintRequest'
    
    validates :model_num, :presence => true 
    validates :status_id, :category_id, :presence => true, :numericality => {:greater_than => 0} 
    validates :name, :presence => true, 
                     :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Name!')}             
    validates :serial_num, :uniqueness => {:scope => :model_num, :case_sensitive => false, :message => I18n.t('Duplicate Serial#!')}
  end
end
