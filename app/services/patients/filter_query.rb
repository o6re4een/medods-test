
module Patients
  class FilterQuery
    def initialize(params)
      @params = params
    end

    def call
      scope = Patient.all

      if @params[:full_name].present?
        name = @params[:full_name].downcase
        first_name, last_name, middle_name = name.split(" ")
        scope = scope.where(
          "TRIM(LOWER(first_name)) LIKE ? OR TRIM(LOWER(last_name)) LIKE ? OR TRIM(LOWER(middle_name)) LIKE ?",
          "%#{first_name}%", "%#{last_name}%", "%#{middle_name}%"
        )
      end

      if @params[:gender].present?
        scope = scope.joins(:gender).where(genders: { name: @params[:gender] })
      end

      if @params[:start_age].present? && @params[:end_age].present?
        from = Date.today - @params[:end_age].to_i.years
        to   = Date.today - @params[:start_age].to_i.years
        scope = scope.where(birthday: from..to)
      end

      scope.limit(@params[:limit] || 20).offset(@params[:offset] || 0).includes(:doctors)
    end
  end
end
