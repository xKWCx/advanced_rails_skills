# Insurance coverage types
module InsuranceCoverage
  BAGGAGE_DELAY = "Baggage Delay"
  EMERGENCY_MEDICAL = "Emergency Medical"
  TRIP_CANCELLATION = "Trip Cancellation"

  # List of all available coverages
  ALL = [
    BAGGAGE_DELAY,
    EMERGENCY_MEDICAL,
    TRIP_CANCELLATION
  ].freeze
end

# Insurance premium calculations
module InsurancePremium
  # Premium adjustments
  BAGGAGE_DELAY_MULTIPLIER = 2
  EMERGENCY_MEDICAL_ADDITION = 50
  TRIP_CANCELLATION_WITH_EM = 75
  TRIP_CANCELLATION_WITHOUT_EM = 100

  # Premium calculation rules
  RULES = {
    InsuranceCoverage::BAGGAGE_DELAY => ->(premium) { premium * BAGGAGE_DELAY_MULTIPLIER },
    InsuranceCoverage::EMERGENCY_MEDICAL => ->(premium) { premium + EMERGENCY_MEDICAL_ADDITION },
    InsuranceCoverage::TRIP_CANCELLATION => ->(premium, has_emergency_medical) {
      premium + (has_emergency_medical ? TRIP_CANCELLATION_WITH_EM : TRIP_CANCELLATION_WITHOUT_EM)
    }
  }.freeze
end
