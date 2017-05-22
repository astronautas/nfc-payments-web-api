class CreateNfcDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :nfc_devices do |t|
      t.string :nfc_id, null: false
      t.timestamps
    end
  end
end
