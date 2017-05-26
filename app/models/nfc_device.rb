class NfcDevice < ApplicationRecord
  belongs_to :order, optional: true
end
