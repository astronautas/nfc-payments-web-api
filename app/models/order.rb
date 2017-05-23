class Order < ApplicationRecord
  def set_confirm
    self[:status] = "Successful"
  end

  def set_failure
    self[:status] = "Failed"
  end
end
