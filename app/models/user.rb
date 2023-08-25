class User < ApplicationRecord

  has_many :courses
  has_many :subscriptions
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_type, inclusion: { in: ['student', 'teacher'],message: "Invalid Type," }
  
end
                                                                                                                                                         