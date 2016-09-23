class Employee < ActiveRecord::Base
	require 'roo'
	belongs_to :company

	validates :first_name, :presence => {:message => 'Ingresar nombre.'}
	validates :curp, :presence => {:message => 'Ingresar Curp.'}
	validates :net_monthly_salary,:presence => {:message => 'Ingresar monto salarial.'}
	validates :admission_date, :presence => {:message => 'Ingresar fecha de admisión.'}
	validates :employee_key, :presence => {:message => 'Ingresar clabe.'}
	validates :payment_cycle, :presence => {:message => 'Ingresar ciclo de pago.'}
	validates :card_id, :presence => {:message => 'Seleccionar tarjeta de credito.'}
	validates :mobile_number, :presence => {:message => 'Ingresa  numero celular.'}
	validates :phone, :presence => {:message => 'Ingresa  numero telefonico.'}
	validates :employee_key,   :presence => {:message => 'Clabe Invalida'},
                     :length => { :minimum => 18, :maximum => 18 }
  	validates :net_monthly_salary, presence:true, numericality: {only_float: true}
  	validates :p_last_name, :presence => {:message => 'Ingresar apellido paterno.'}
  	validates :m_last_name, :presence => {:message => 'Ingresar apellido materno.'}
  	validates :birthdate, :presence => {:message => 'Ingresar fecha de nacimiento.'}
  	validates :place_birth, :presence => {:message => 'Ingresar lugar de nacimiento.'}
  	validates :brut_monthly_salary, :presence => {:message => 'Ingresar salario bruto.'}
  	validates :disponible, :presence => {:message => 'Ingresar disponibilidad.'}



  has_many :loans 

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    employee = find_by_id(row["id"]) || new
	    employee.attributes = row.to_hash.slice(*accessible_attributes)
	    employee.save(:validate=>false)
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when '.csv' then Roo::Csv.new(file.path)
	  when '.xls' then Roo::Excel.new(file.path)
	  when '.xlsx' then Roo::Excelx.new(file.path)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	private
		def self.accessible_attributes
		 ["first_name", "curp", "net_monthly_salary", "admission_date", "employee_key", "payment_cycle", "card_id", "company_id", "mobile_number", "activation_code","p_last_name", "m_last_name", "birthdate", "place_birth", "brut_monthly_salary", "disponible", "credit_line"]
		end

end
