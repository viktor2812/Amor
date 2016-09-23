class CardPdf < Prawn::Document
	def initialize(card)
		super()
		@card = Card.order("id DESC").all
		tabla		
	end
	def tabla
		table tarjetas do
			row(0).font_style = :bold
			columns(1..3).align = :rigth
			self.row_colors = ["DDDDDD","FFFFFF"]
			self.header = true
		end
	end
	def tarjetas
      [["Numero de Tarjeta", "Fecha de Expedición", "Emisor", "Status"]] +
      @card.map do |tarjeta| 
      	[tarjeta.cardNumber, tarjeta.expDate, tarjeta.emisor, tarjeta.statuss]             
      end 
	end
end