class NfcController < ApplicationController
  before_filter :authenticate_request!

  def register
    nfc = NfcDevice.new(nfc_id: (0...8).map { (65 + rand(26)).chr }.join)

    if nfc.save
      render json: {status: 'Device registered!', device_id: nfc.nfc_id}, status: :ok
    else
      render json: {status: 'Device not registered!'}, status: :bad_request
    end

  end
end
