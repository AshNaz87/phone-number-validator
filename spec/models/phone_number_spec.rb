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

require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  describe 'Phone number creation' do
    it 'has to be present' do
      number = PhoneNumber.create(digits: '07595766622')
      expect(number.valid?).to eq(true)
    end
  end
end
