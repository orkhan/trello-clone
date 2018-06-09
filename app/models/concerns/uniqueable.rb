module Uniqueable
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  protected

    def generate_uid
      self.uid = loop do
        random_uid = SecureRandom.urlsafe_base64(10)
        break random_uid unless self.class.exists?(uid: random_uid)
      end
    end
end