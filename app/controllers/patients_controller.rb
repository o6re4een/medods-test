
class PatientsController < ApplicationController
  def index
    patients = Patients::FilterQuery.new(params).call
    render json: patients.to_json(include: [:doctors, :gender])
  end



  def create
    Rails.logger.debug "CREATE PARAMS: #{params.to_unsafe_h}"


    attrs = patient_params.to_h
    return unless get_gender_or_throw(attrs)

    patient = Patient.new(attrs)

    if patient.save
      patient.reload
      render json: patient.as_json(include: :doctors), status: :created
    else
      render json: {errors: patient.errors}, status: :unprocessable_entity

    end
  end

  def update
    patient = Patient.find(params[:id])
    Rails.logger.debug "UPDATE PARAMS: #{params.to_unsafe_h}"

    attrs = patient_params.to_h
    return unless get_gender_or_throw(attrs)


    if patient.update(attrs)
      patient.reload
      render json: patient.as_json(include: :doctors), status: :ok
    else
      render json: {errors: patient.errors}, status: :unprocessable_entity
    end

  end

  def destroy
    patient = Patient.find(params[:id])
    Rails.logger.debug "DELETE PARAMS: #{params.to_unsafe_h}"
    patient.destroy
    render json: "Deleted #{patient.first_name} #{patient.last_name?}", status: :no_content
  end

  private
  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :middle_name, :birthday, :height, :weight, :gender, doctor_ids: [],)

  end

  def get_gender_or_throw(attrs)
    gender_name = attrs.delete(:gender) || attrs.delete('gender')
    return true if attrs['gender_id'].present? || attrs[:gender_id].present?
    return true unless gender_name.present?

    gender = Gender.find_by(name: gender_name)
    unless gender
      render json: { errors: ["Gender '#{gender_name}' not found"] }, status: :unprocessable_entity
      return false
    end

    attrs['gender_id'] = gender.id
    true

  end

end
