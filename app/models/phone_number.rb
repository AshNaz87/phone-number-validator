# frozen_string_literal: true

# == Schema Information
#
# Table name: phone_numbers
#
#  id         :bigint           not null, primary key
#  digits     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Phone Number model
class PhoneNumber < ApplicationRecord
  attr_accessor :digits

  validates :digits, presence: true
end
