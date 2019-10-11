require "spec_helper"

describe NorwegianNationalIdParser do
  it "has a version number" do
    expect(NorwegianNationalIdParser::VERSION).not_to be nil
  end

  describe '#initialize' do
    it 'should raise an error if national id is empty' do
      empty_parameters = [" ", nil, "", "    "]

      empty_parameters.each do |param|
        expect {
          described_class.parse(param)
        }.to raise_error described_class::IdMissingError
      end
    end

    it 'should raise an error if national id is of wrong length' do
      wrong_formats = [ "0000000000", "000000000000" ]

      wrong_formats.each do |wrong_length|
        expect {
          described_class.parse(wrong_length)
        }.to raise_error described_class::WrongLengthError
      end
    end

    it 'should raise an error if national id contains non numeric characters' do
        expect {
          described_class.parse("000000a0000")
        }.to raise_error described_class::InvalidCharactersError
    end

    it 'should not raise an error on valid national ids' do
      valid_ids = [
        '29068397136',
        '05075245108',
        '30030446646',
        '18114544082',
        '07021203747',
        '06090516025',
        '25090312084',
        '28071145052',
        '11084524338',
        '13042046846'
      ]

      valid_ids.each do |valid_id|
        expect {
          described_class.parse(valid_id)
        }.not_to raise_error
      end
    end

    it 'should return correct date of birth for a d-number' do
      d_number = '65038300827'

      parsed_id = described_class.parse(d_number)

      expect(parsed_id.birth_date).to eq(Date.new(1983, 3, 25))
    end
  end
end
