require 'securerandom'

class Purchase < ActiveRecord::Base
  belongs_to :cat

  validates :cat, presence: true
  validates :price, presence: true
  validates :purchaser_name, presence: true
  validates :token, presence: true

  # before_validation :set_token
  #
  # def set_token
  #   self.token = SecureRandom.urlsafe_base64
  # end

end
