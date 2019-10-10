require_relative 'date_parser'

module NorwegianNationalIdParser
  class NationalIdValidator
    def initialize(national_id)
      @national_id = national_id
    end

    def call
      validate_presence
      validate_length
      validate_numeric
      validate_date
      validate_control_numbers
    end

    private

    def validate_presence
      if !@national_id || @national_id.empty?
        raise IdMissingError
      end
    end

    def validate_length
      if @national_id.length != ID_LENGTH
        raise WrongLengthError
      end
    end

    def validate_numeric
      unless @national_id.match(/\D/).nil?
        raise InvalidCharactersError
      end
    end

    def validate_date
      DateParser.new(@national_id)
    end

    def validate_control_numbers
      d1 = lookup_digit(0)
      d2 = lookup_digit(1)
      m1 = lookup_digit(2)
      m2 = lookup_digit(3)
      y1 = lookup_digit(4)
      y2 = lookup_digit(5)
      i1 = lookup_digit(6)
      i2 = lookup_digit(7)
      i3 = lookup_digit(8)

      k1 = 11 - ((3 * d1 + 7 * d2 + 6 * m1 + 1 * m2 + 8 * y1 + 9 * y2 + 4 * i1 + 5 * i2 + 2 * i3) % 11)
      k2 = 11 - ((5 * d1 + 4 * d2 + 3 * m1 + 2 * m2 + 7 * y1 + 6 * y2 + 5 * i1 + 4 * i2 + 3 * i3 + 2 * k1) % 11)
      k1 = 0 if k1 == 11
      k2 = 0 if k2 == 11

      unless lookup_digit(CONTROL_NUMBER_1) == k1 &&
             lookup_digit(CONTROL_NUMBER_2) == k2
        raise InvalidControlNumberError
      end
    end

    private

    def lookup_digit(i)
      @national_id[i].to_i
    end
  end
end
