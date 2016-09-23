class AddIdCardToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :cards, index: true, foreign_key: true
  end
end