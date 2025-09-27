class DoctorsController < ApplicationController
  def index
    doctors = Doctor.limit(params[:limit] || 20).offset(params[:offset] || 0)
    render json: doctors
  end

  def show
    doctor = Doctor.find(params[:id])
    render json: doctor
  end

  def create
    doctor = Doctor.new(doctor_params)
    if doctor.save
      render json: doctor, status: :created
    else
      render json: { errors: doctor.errors }, status: :unprocessable_entity
    end
  end

  def update
    doctor = Doctor.find(params[:id])
    Rails.logger.debug "UPDATE PARAMS: #{params.to_unsafe_h}"

    if doctor.update(doctor_params)
      render json: doctor, status: :ok
    else
      render json: { errors: doctor.errors }, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :middle_name)
  end
end
