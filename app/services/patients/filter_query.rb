
module Patients
  class FilterQuery
    def initialize(params)
      @params = params
    end

    def call
      scope = Patient.includes(:doctors).includes(:gender).all

      if @params[:full_name].present?
        name = @params[:full_name].strip.downcase!
        reversed_name = @params[:full_name].split(' ').reverse.join(' ').downcase!


        scope = scope.where("full_name ILIKE :name OR full_name ILIKE :reversed_name",
                            name: "%#{name}%", reversed_name: "%#{reversed_name}%")
      end

      if @params[:gender].present?
        scope = scope.joins(:gender).where(genders: { name: @params[:gender] })
      end

      if @params[:start_age].present? && @params[:end_age].present?
        from = Date.today - @params[:end_age].to_i.years
        to   = Date.today - @params[:start_age].to_i.years
        scope = scope.where(birthday: from..to)
      end


     scope.limit(@params[:limit] || 20).offset(@params[:offset] || 0)

    end
  end
end
