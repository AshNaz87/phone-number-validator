# frozen_string_literal: true

require 'phone_number_errors'

# Returns valid phone numbers to UK format
module Formatter
  CODE = '+44'
  PLUS = '+'

  class << self
    def strip_white_spaces?(number)
      number.gsub!(/\s+/, '')
    end

    def strip_prefix?(number)
      number.gsub!(/\+?44/, '')
    end

    def number_too_short?(number)
      strip_prefix?(number)
      number.match(phone_regex) && number.length < 11
    end

    def number_too_long?(number)
      strip_prefix?(number)
      number.match(phone_regex) && number.length > 9
    end

    def format(number)
      correct_argument?(number)

      strip_white_spaces?(number)

      return number if number.match(prefix_regex) && number.start_with?(CODE)

      return PLUS.dup << number if number.match(prefix_regex) && !number.start_with?(CODE)

      return CODE.dup << number.slice(1..-1) if number.match(standard_regex)

      raise_error?(number)
    end

    private

    def correct_argument?(number)
      raise PhoneNumberValidations::NotNumberError, 'Argument passed is not a string' unless number.is_a? String
    end

    def prefix_regex
      Regexp.new(/\A\+?44(?=7)\d{10}\z/)
    end

    def standard_regex
      Regexp.new(/\A07(?=)\d{9}\z/)
    end

    def phone_regex
      Regexp.new(/\A0?7\d+\z/)
    end

    def raise_error?(number)
      raise PhoneNumberValidations::NumberTooShortError if number_too_short?(number)

      raise PhoneNumberValidations::NumberTooLongError if number_too_long?(number)

      raise PhoneNumberValidations::InvalidNumberError
    end
  end
end
