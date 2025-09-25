class BmrsController < ApplicationController
  def history
    patient = Patient.find(params[:id])

    history = patient.bmr_histories.limit(params[:limit] || 20).offset(params[:offset] || 0)
    render json: history
  end

  def calculate
    patient = Patient.find(params[:id])
    result = Patients::BmrService.new(patient, params[:formula]).call
    render json: { patient_id: patient.id, formula: params[:formula], result: result }
  end
end
