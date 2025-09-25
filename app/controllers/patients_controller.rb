
class PatientsController < ApplicationController
  def index
    patients = Patients::FilterQuery.new(params).call
    render json: patients.as_json(include: [:doctors])
  end

  def show
    genders = Gender.all
    render json: genders
  end

  def create
    gender = Gender.find_by(name: params[:gender])
    patient = Patient.new(patient_params)
    patient.gender = gender
    if patient.save
      render json: patient, status: :created
    else
      render json: {errors: patient.errors}, status: :unprocessable_entity

    end
  end

  def update
    patient = Patient.find(params[:id])
    if patient.update(patient_params)
      render json: patient
    else
      render json: { errors: patient.errors }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :middle_name, :birthday, :height, :weight, :gender, doctor_ids: [])

  end

end
