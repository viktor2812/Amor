json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :curp, :net_monthly_salary, :admission_date, :employee_key, :payment_cycle, :card_id, :company_id, :mobile_number, :activation_code,:p_last_name, :m_last_name, :birthdate, :place_birth, :brut_monthly_salary, :disponible, :credit_line
  json.url employee_url(employee, format: :json)
end
