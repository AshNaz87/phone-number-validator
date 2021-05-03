# frozen_string_literal: true

require 'formatter'
require 'phone_number_errors'
require 'YAML'

require_relative 'helpers/argument_helper'

RSpec.describe 'Phone Number Errors' do
  context 'argument being passed in' do
    it 'returns argument error if not a string' do
      error = 'Argument passed is not a string'
      expect { format_block(INVALID_PHONE_NUMBERS[:non_strings].all?) }.to raise_error(error)
    end
  end
end
