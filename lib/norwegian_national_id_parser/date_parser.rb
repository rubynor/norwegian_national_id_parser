module NorwegianNationalIdParser
  class DateParser
    attr_reader :date

    def initialize(national_id)
      @national_id = national_id
      @date = parse_date
    end

    def type
      if d_number?
        'd_number'
      elsif h_number?
        'h_number'
      else
        'normal'
      end
    end

    private

    def parse_date
      validate_century

      Date.new(year, month, day)
    rescue ArgumentError
      raise DateInvalidError
    end

    def year
      century + part_of_id(YEAR)
    end

    def month
      if h_number?
        return part_of_id(MONTH) - H_NUMBER_VALUE
      end

      part_of_id(MONTH)
    end

    def day
      if d_number?
        return part_of_id(DAY) - D_NUMBER_VALUE
      end

      part_of_id(DAY)
    end

    def validate_century
      if century.nil? || century < 1
        raise IndividualDigitsParseError
      end
    end

    def century
      INDIVIDUAL_DIGITS_CENTURY_MAP
        .detect { |k,v| k === part_of_id(INDUVIDUAL_DIGITS) }.last
        .detect { |k,v| k === part_of_id(YEAR) }.last
    end

    def d_number?
      part_of_id(DAY) > 40
    end

    def h_number?
      part_of_id(MONTH) > 40
    end

    def part_of_id(part)
      @national_id[*part].to_i
    end
  end
end
