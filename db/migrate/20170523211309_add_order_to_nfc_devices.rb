class AddOrderToNfcDevices < ActiveRecord::Migration[5.0]
  def change
    add_reference :nfc_devices, :order, foreign_key: true
  end
end
