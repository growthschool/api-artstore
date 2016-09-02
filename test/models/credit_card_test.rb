require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: credit_cards
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  token       :string
#  brand       :string
#  last4       :string
#  fingerprint :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
