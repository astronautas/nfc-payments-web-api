class AddStatusToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :status, :string
    add_column :orders, :amount, :string
  end
end
