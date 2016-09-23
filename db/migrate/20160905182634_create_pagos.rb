class CreatePagos < ActiveRecord::Migration
  def change
    create_table :pagos do |t|
      t.integer :loan_id
      t.float :monto_pago
      t.float :interes
      t.float :iva_sobre_interes
      t.float :total
      t.string :status_pago
      t.timestamps null: false
    end
  end
end