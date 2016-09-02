class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :credit_cards

  before_save do
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def authenticate(password)
    !!valid_password?(password) 
  end

  def create_card!(number, cvc, exp_month, exp_year)
    create_token = StripeWrapper::Token.new(:number => number,
    :cvc => cvc, :exp_month => exp_month, :exp_year => exp_year).create

    if create_token.successful?

      stripe_card = create_token.response.card
      cd = credit_cards.build
      cd.token = stripe_card.id
      cd.last4 = stripe_card.last4
      cd.brand = stripe_card.brand
      cd.fingerprint = stripe_card.fingerprint
      cd.save

      # TODO : validate fingerprint
    end
    
    return create_token

  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authentication_token   :string
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
