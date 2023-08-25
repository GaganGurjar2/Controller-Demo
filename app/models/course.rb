class Course < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_many :practice_questions
  has_many :subscriptions 
  validate :teacher_create_course

  private
   def teacher_create_course
    if user.present? && user.user_type != 'teacher'
      errors.add(:user,"only teacher create course")
    end 
  end

end
