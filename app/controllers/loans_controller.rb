class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]



  # GET /loans
  # GET /loans.json
  def index
    @loan = Loan.all
    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    @id_ploy = loan_params[:employee_id]
    @max = loan_params[:capital_requisition]
    cd = loan_params[:max_credit]

    if verificar == true
      respond_to do |format|
        if @loan.save
          format.html { redirect_to @loan }
          format.json { render :show, status: :created, location: @loan }
          set_pago
        else
          format.html { render :new }
          format.json { render json: @loan.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to loans_url, notice: "Revisar prestamos maximo de credito: #{loan_params[:max_credit]}::: Sobre pasa #{@res}" 
    end
  end

#Verificacion de prestamos si cuenta ya con uno y si si que no pase su limite maximode credito 
  def verificar
    p1 = Loan.where(employee_id: @id_ploy).take

    if p1 != nil 
      @comp = Loan.where(employee_id: @id_ploy).pluck(:capital_requisition)
      sum = 0
      @comp.each { |a| sum+=a.to_i}
      @res = @max.to_i + sum

      if @res  <= p1.max_credit
        return true
      else
        return false
      end     
    else
      return true
    end 

  end
     
     

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'El prestamo se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'El prestamo se ha eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def set_pago
      m = loan_params[:capital_requisition].to_i
      if m==0

      else

      i = loan_params[:interest].to_i
      inters =  (m * i).to_f / 100
      iva_interes = inters * 16 / 100.0
      t =  inters + iva_interes + m
      h = Hash.new  
      h = {'monto_pago' => loan_params[:capital_requisition],
           'interes' => inters,
           'iva_sobre_interes' => iva_interes,
           'total' => t,
           'status_pago' => 'Pendiente'
          }
      @pago = Pago.new(h)
      @pago.save
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:employee_id, :net_salary, :interest, :max_credit, :period, :capital_requisition, :date_requisition, :capital_to_pay, :balance, :status)
    end
end