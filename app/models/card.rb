class Card < ActiveRecord::Base
require 'roo'
	
	belongs_to :employee
	validates :cardNumber,  :presence => {:message => 'Por favor, Ingrese el Numero de Tarjeta'}
	validates :emisor,  :presence => {:message => 'Por favor, Ingrese el Emisor'}
	validates :statuss, :presence => {:message => 'Por favor, Ingrese el Status 0 = Inactivo o 1 = Activo'}
	


def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |product|
      csv << product.attributes.values_at(*column_names)
    end
  end
end




	def self.import(file)
	if file != nil 
		spreadsheet = open_spreadsheet(file) 
		if spreadsheet == false 
		else 
			header = spreadsheet.row(1) 
			(2..spreadsheet.last_row).each do |i| 
				row = Hash[[header, spreadsheet.row(i)].transpose]  
				tarjeta_archivo = spreadsheet.row(i)
				if Card.where(cardNumber: tarjeta_archivo[0]).take 
					verificacion = true 
				else  
					verificacion = false 
				end 

				if verificacion == false 
					card = find_by_id(row["id"]) || new  
					card.attributes = row.to_hash.slice(*accessible_attributes) 
					card.save(:validate=>false) 					 
				else  
					@card = Card.find(1)   			
				end 
			end	
		end 
	end
	end

	def self.open_spreadsheet(file)	
		if file != nil 
			case File.extname(file.original_filename) 
			when '.csv' then Roo::Csv.new(file.path) 
			when '.xls' then Roo::Excel.new(file.path) 
			when '.xlsx' then Roo::Excelx.new(file.path) 
			else 
				false 
			end 
		end
	end

	private
		def self.accessible_attributes 
			["id", "cardNumber", "expDate", "emisor", "statuss"]
		end

	
	
end