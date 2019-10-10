require "norwegian_national_id_parser/version"
require "norwegian_national_id_parser/parser"

module NorwegianNationalIdParser
  class NationalIdError < StandardError ; end

  class IndividualDigitsParseError < NationalIdError ; end
  class InvalidControlNumberError  < NationalIdError ; end
  class InvalidCharactersError     < NationalIdError ; end
  class WrongLengthError           < NationalIdError ; end
  class DateInvalidError           < NationalIdError ; end
  class IdMissingError             < NationalIdError ; end

  ID_LENGTH = 11

  DAY = [0,2]
  MONTH = [2,2]
  YEAR = [4,2]
  INDUVIDUAL_DIGITS = [6,3]
  GENDER = 8
  CONTROL_NUMBER_1 = 9
  CONTROL_NUMBER_2 = 10

  D_NUMBER_VALUE = 40
  H_NUMBER_VALUE = 40

  INDIVIDUAL_DIGITS_CENTURY_MAP = {
    0..499 => { 
      00..99 => 1900
    },
    500..749 => {
      54..99 => 1800,
      0..39 => 2000
    },
    750..899 => {
      0..39 => 2000
    },
    900..999 => {
      0..39 => 2000,
      40..99 => 1900
    }
  }

  def self.parse(national_id)
    Parser.new(national_id)
  end
end
