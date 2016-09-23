json.array!(@pagos) do |pay|
  json.extract! pay, :id, :fk_loan_id, :monto_pago, :interes, :sub_total, :iva_sobre_interes, :total, :status_pago
  json.url pago_url(pay, format: :json)
end