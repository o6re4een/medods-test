require 'net/http'

module Patients
  class BmiService
    API_URL = "https://bmicalculatorapi.vercel.app/api/bmi"

    def initialize(patient)
      @patient = patient
    end

    def call
      uri = URI(API_URL + "/#{@patient.weight}" + "/#{@patient.height.to_f/100}")

      res = Net::HTTP.get_response(uri)
      unless res.is_a?(Net::HTTPSuccess)
        raise "BMI API error: #{res.code} #{res.message}"
      end
      JSON.parse(res.body)
    end
  end
end