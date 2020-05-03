class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true, 
                    fromat: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private
    def downcase_email
      email.downcase!
    end
end
