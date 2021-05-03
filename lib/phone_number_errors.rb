# frozen_string_literal: true

# Phone number validation errors
module PhoneNumberValidations
  # If argument is not a string
  class NotNumberError < ArgumentError
    attr_reader :message

    def initialize(message)
      @message = message
      super
    end
  end

  # If number is not valid
  class InvalidNumberError < StandardError
    def initialize(message = 'Number entered is not valid')
      super
    end
  end

  class NumberLengthError < StandardError; end

  # If phone number is too short error
  class NumberTooShortError < NumberLengthError
    def initialize(message = 'Phone number is too short')
      super
    end
  end

  # If phone number is too long error
  class NumberTooLongError < NumberLengthError
    def initialize(message = 'Phone number is too long')
      super
    end
  end
end
