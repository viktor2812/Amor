class Company < ActiveRecord::Base
   validates :company_name, :presence => {:message => 'Ingresar Empresa.'}
    validates :sub_company, :presence => {:message => 'Ingresar Sub-Empresa.'}
	validates :calendar_schema, presence: false
    validates :street, :presence => {:message => 'Ingresar calle.'}
    validates :num_int, :presence => {:message => 'Ingresar numero interior.'}
    validates :num_out, :presence => {:message => 'Ingresar numero exterior.'}
    validates :location, :presence => {:message => 'Ingresar localidad.'}
    validates :delegation, :presence => {:message => 'Ingresar delegacion.'}
    validates :city, :presence => {:message => 'Ingresar ciudad.'}
    validates :cp, :presence => {:message => 'Ingresar codigo postal.'}
    validates :payment_schema, :presence => {:message => 'Ingresar esquema de pagos.'}
    validates :contact_name, :presence => {:message => 'Ingresar nombre del contacto.'}
    validates :contact_p_last_name, :presence => {:message => 'Ingresar apellido paterno.'}
    validates :contact_m_last_name, :presence => {:message => 'Ingresar apellido materno.'}
    validates :contact_email, :presence => {:message => 'Ingresar email.'}
    validates :contact_telephone, :presence => {:message => 'Ingresar numero telefonico.'}
    validates_format_of :contact_email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
    validates :contact_telephone, :presence => {:message => 'El contacto telefónico es invalido'},
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
    validates :rfc_company, :presence => {:message => 'Ingresar RFC.'}
    validates :agent_name, :presence => {:message => 'Ingresar nombre .'}
    validates :agent_p_last_name, :presence => {:message => 'Ingresar apellido paterno.'}
    validates :agent_m_last_name, :presence => {:message => 'Ingresar apellido materno.'}
    validates :agent_email, :presence => {:message => 'Ingresar email .'}
    validates :agent_telephone, :presence => {:message => 'Ingresar telefono.'}
    validates :rfc_agent, :presence => {:message => 'Ingresar RFC.'}
    validates :agent_telephone,   :presence => {:message => 'El contacto telefónico es invalido'},
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
    
  belongs_to :user
  has_many :employees
end
