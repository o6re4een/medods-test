class GenderController < ApplicationController
  def index
    genders = Gender.all
    if genders
      render json: genders

    else
      render json: []

    end
  end

  def create
    gender = nil
    unless params[:gender]
      return render json: { error: "invalid gender" }
    end

    gender = Gender.new
    gender.assign_attributes(name: params[:gender])
    if gender.save
      render json: gender

    else
      render json: { error: "Error #{gender.errors.messages}" }
    end
  end

  def update
  end

  private

  def gender_params
    params.permit(:gender)
  end

end
