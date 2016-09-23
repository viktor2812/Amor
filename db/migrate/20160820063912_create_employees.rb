class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      
      t.string :first_name
      t.string :curp
      t.float :net_monthly_salary
      t.date :admission_date
      t.bigint :employee_key 
      t.string :payment_cycle
      t.integer :card_id
      t.integer :company_id
      t.bigint :mobile_number
      t.bigint :phone
      t.string :activation_code

###################################

      t.string :p_last_name
      t.string :m_last_name
      t.date :birthdate
      t.string :place_birth
      t.float :brut_monthly_salary
      t.string :disponible
      t.string :credit_line

      t.timestamps null: false
    end
  end
end


#first_name
#surname
#curp
#net_monthly_salary
#admission_date
#payment_cycle
#card_id
#company_id
#mobile_number
#activation_code