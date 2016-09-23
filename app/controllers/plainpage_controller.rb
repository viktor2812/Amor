class PlainpageController < ApplicationController
	before_action :authenticate_user!

  def index
    
    @total_comp = Company.count
    @total_subcom = Company.order(:sub_company).count
    @total_cliente = Employee.count
    @total_tajetas_ac = Card.where(statuss: 2).count
    @total_pagos = Pago.where(status_pago: 'Pendiente').sum(:total)   
    @mes_ante_comp = Company.where(created_at: (Time.now.midnight - 1.month)..Time.now.midnight).count 
    @mes_ante_subcom = Company.order(:sub_company).where(created_at: (Time.now.midnight - 1.month)..Time.now.midnight).count
    @mes_ante_clien = Employee.where(created_at: (Time.now.midnight - 1.month)..Time.now.midnight).count 
    @mes_ante_tar = Card.where(expDate: (Time.now.midnight - 1.month)..Time.now.midnight).count
    @mes_ante_pag = Pago.where(created_at: (Time.now.midnight - 1.month)..Time.now.midnight).count 
    @porcentaje_comp = @total_comp*@mes_ante_comp.to_f/100
	@porcentaje_subcom = @total_subcom*@mes_ante_subcom.to_f/100
	@porcentaje_clien = @total_cliente*@mes_ante_clien.to_f/100
    @porcentaje_ta = @total_tajetas_ac*@mes_ante_tar.to_f/100
    @porcentaje_pagos = @total_pagos*@mes_ante_pag.to_f/100

      end
end
