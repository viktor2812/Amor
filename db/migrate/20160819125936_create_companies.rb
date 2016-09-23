class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :sub_company
      #t.integer :calendar_schema
      t.string :payment_schema
      t.string :contact_name
      t.string :contact_p_last_name
      t.string :contact_m_last_name
      t.string :contact_email
      t.integer :contact_telephone, :limit => 8
      t.string :rfc_company
      t.string :street
      t.integer :num_out
      t.integer :num_int
      t.string :location
      t.string :delegation
      t.string :city
      t.integer :cp
      t.string :agent_name
      t.string :agent_p_last_name
      t.string :agent_m_last_name
      t.string :agent_email
      t.integer :agent_telephone, :limit => 8
      t.string :rfc_agent

      t.timestamps null: false
    end
  end
end
