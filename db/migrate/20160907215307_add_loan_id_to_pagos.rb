class AddLoanIdToPagos < ActiveRecord::Migration
  def change
    add_reference :pagos, :loans, index: true, foreign_key: true
  end
end
