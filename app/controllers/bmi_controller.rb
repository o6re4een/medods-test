class BmiController < ApplicationController
  def calculate

    patient = nil

    begin
      patient = Patient.find(params[:id])
    rescue => error
      return render json: { error: "#{error}" }

    end
    result = Patients::BmiService.new(patient).call
    render json: result
  end
end
