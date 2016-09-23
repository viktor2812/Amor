class CardsController < ApplicationController
	before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  # GET /cards.json

def index
  
  @card = Card.paginate(:page => params[:page], :per_page => 15)    
  @card = Card.order("id DESC")
  respond_to do |format|
    format.html
    format.csv { send_data @card.to_csv }
      format.xls
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text 'Genera PDFs Conforme a Los Reportes Sugeridos'
        send_data pdf.render, filename: 'cards.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
end

def pdf
  @card = Card.order("id DESC").all
    respond_to do |format|
      format.html
      format.csv { send_data @card.to_csv }
      format.xls
      format.pdf do
        pdf = CardPdf.new(@card)
        send_data pdf.render, filename: 'cards.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end  
end
  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  def verificar
    if Card.where(cardNumber: @tar).take 
    return true
    else
    return false
    end  
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)
    @tar = card_params[:cardNumber]
    #raise"#{card_params}"
    if verificar == true
      redirect_to cards_url, notice: "Tarjeta Duplicada Ingresa Otra"   
    else
    respond_to do |format|
      if @card.save
        format.html { redirect_to @card}
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card}
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end

  def import
    if params.include?("file") or params.include?(".csv") or params.include?(".xls") or params.include?(".xlsx") 
      Card.import(params[:file])
      redirect_to cards_url, notice:  Card.count == @count_init ? "Tarjeta(s) Con valores Diferentes": "Tarjeta(s) importada(s)."     
    else        
      redirect_to cards_url, notice: "Elije un Archivo para Cargar o Verifica si el Archivo es el Correcto"
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:cardNumber, :expDate, :emisor, :statuss)
    end
end
