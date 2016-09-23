class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = current_user.companies.paginate(:page => params[:page], :per_page => 15)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = current_user.companies.build
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    company_params[:rfc_company].upcase!
    company_params[:rfc_agent].upcase!
    company_params[:contact_name].capitalize!
    company_params[:contact_p_last_name].capitalize!
    company_params[:contact_m_last_name].capitalize!
    company_params[:agent_name].capitalize!
    company_params[:agent_p_last_name].capitalize!
    company_params[:agent_m_last_name].capitalize!
    company_params[:location].capitalize!
    company_params[:delegation].capitalize!
    company_params[:city].capitalize!


    @company = current_user.companies.build(company_params)
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company}
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    company_params[:rfc_company].upcase!
    company_params[:rfc_agent].upcase!
    company_params[:contact_name].capitalize!
    company_params[:contact_p_last_name].capitalize!
    company_params[:contact_m_last_name].capitalize!
    company_params[:agent_name].capitalize!
    company_params[:agent_p_last_name].capitalize!
    company_params[:agent_m_last_name].capitalize!
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company}
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def ciclo_pago    
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:company_name, :sub_company, :street,:num_out,:num_int,:location,:delegation,:city,:cp,:payment_schema, :contact_name,:contact_p_last_name,:contact_m_last_name, :contact_email, :contact_telephone, :rfc_company ,:agent_name,:agent_p_last_name,:agent_m_last_name, :agent_email, :agent_telephone, :rfc_agent)
    end
end
