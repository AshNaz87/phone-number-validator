# frozen_string_literal: true

require 'formatter'
require 'phone_number_errors'
require 'YAML'

INVALID_PHONE_NUMBERS = YAML.load_file File.join(File.dirname(__FILE__), '../fixtures/invalid_phone_numbers.yml')
VALID_PHONE_NUMBERS = YAML.load_file File.join(File.dirname(__FILE__), '../fixtures/valid_phone_numbers.yml')

RSpec.describe Formatter do
  describe 'the format method' do
    it 'prefixes correctly formatted UK numbers with country code' do
      output = %w[+447595766622 +447777777777 +447912345678 +447412345678 +447333333333]

      formatted_numbers = VALID_PHONE_NUMBERS[:standard].map do |number|
        Formatter.format(number)
      end

      expect(formatted_numbers).to eq(output)
    end

    it 'returns correctly formatted UK numbers' do
      output = %w[+447777777777 +447912345678 +447595766622 +447777777777 +447912345678]

      formatted_numbers = VALID_PHONE_NUMBERS[:prefix_four_four].map do |number|
        Formatter.format(number)
      end

      expect(formatted_numbers).to eq(output)
    end
  end

  describe 'errors raised' do
    check = ->(argument) { Formatter.format(argument) }

    it 'raises an error if phone number is too short' do
      error = 'Phone number is too short'
      expect { INVALID_PHONE_NUMBERS[:short_numbers].all?(&check) }.to raise_error(error)
    end

    it 'raises an error if phone number is too long' do
      error = 'Phone number is too long'
      expect { INVALID_PHONE_NUMBERS[:long_numbers].all?(&check) }.to raise_error(error)
    end

    it 'raises an error if phone number format is incorrect' do
      error = 'Number entered is not valid'
      expect { INVALID_PHONE_NUMBERS[:incorrect_format].all?(&check) }.to raise_error(error)
    end
  end
end
