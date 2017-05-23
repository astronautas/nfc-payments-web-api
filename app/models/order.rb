class Order < ApplicationRecord
  def confirm
    self[:status] = "Successful"
  end

  def set_failure
    self[:status] = "Failed"
  end
end
