require_relative 'date_parser'
require_relative 'national_id_validator'

module NorwegianNationalIdParser
  class Parser
    attr_reader :national_id

    def initialize(national_id)
      self.national_id = national_id
    end

    def national_id=(national_id)
      national_id = national_id&.delete(' ')

      NationalIdValidator.new(national_id).call()

      @national_id = national_id
    end

    def birth_date
      DateParser.new(@national_id).date
    end

    def age
      calc_age(birth_date)
    end

    def gender
      if @national_id[GENDER].to_i.even?
        'female'
      else
        'male'
      end
    end

    private

    def calc_age(dob)
      now = Date.today
      year_diff = now.year - dob.year
      year_diff - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end
end
