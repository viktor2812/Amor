class AddEmployeeIdToLoans < ActiveRecord::Migration
  def change
    add_reference :loans, :employees, index: true, foreign_key: true
  end
end
