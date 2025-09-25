require 'net/http'

module Patients
  class BmiService
    API_URL = "https://bmicalculatorapi.vercel.app/api/bmi"

    def initialize(patient)
      @patient = patient
    end

    def call
      uri = URI(API_URL + "/#{@patient.weight}" + "/#{@patient.height.to_f/100}")
      # uri.query = URI.to_query(height: @patient.height, weight: @patient.weight)
      # URI = URI + "/"
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)
    end
  end
end