module Patients
  class BmrService
    FORMULS = {
      'mifflin' => ->(patient) {
        if patient.gender.name == 'male'
          10 * patient.weight + 6.25 * patient.height - 5 * patient.age + 5
        else
          10 * patient.weight + 6.25 * patient.height - 5 * patient.age - 161
        end
      },
      'harris' => ->(patient) {
        if patient.gender.name == 'male'
          66.5 + (13.75 * patient.weight) + (5.003 * patient.height) - (6.755 * patient.age)
        else
          655.1 + (9.563 * patient.weight) + (1.850 * patient.height) - (4.676 * patient.age)
        end
      }
    }

    def initialize(patient, formula_name)
      @patient = patient
      @formula_name = formula_name.to_s
      @formula_proc = FORMULS[@formula_name]
    end

    def call
      raise ArgumentError, "Unsupported formula: #{@formula_name}" unless @formula_name

      result = @formula_proc.call(@patient)
      formula = Formula.find_by!(name: @formula_name)

      BmrHistory.create!(
        patient: @patient,
        formula: formula,
        result: result,
        calculated_on: Date.current,
      )
      result
    end

  end
end