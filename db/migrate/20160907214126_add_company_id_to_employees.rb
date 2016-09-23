class AddCompanyIdToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :companies, index: true, foreign_key: true
  end
end
