class BmiController < ApplicationController
  def calculate
    patient = Patient.find(params[:id])
    result = Patients::BmiService.new(patient).call
    render json: result
  end
end
