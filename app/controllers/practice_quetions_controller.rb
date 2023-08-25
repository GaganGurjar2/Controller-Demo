class PracticeQuetionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_practice_question, only: [:show, :update, :destroy]
  before_action :authorize_teacher, only: [:create, :update, :destroy]

 
  def index
    if current_user.user_type == 'teacher'
      @practice_questions = @course.practice_questions
    elsif current_user.user_type == 'student'
      @practice_questions = current_user.courses.exists?(@course) ? @course.practice_questions : []
    end
    render json: @practice_questions
  end

  
  def create
    @practice_question = @course.practice_questions.build(practice_question_params)
    if @practice_question.save
      render json: @practice_question, status: :created
    else
      render json: @practice_question.errors, status: :unprocessable_entity
    end
  end
     
  def show
    render json: @practice_question
  end

  
  def update
    if @practice_question.update(practice_question_params)
      render json: @practice_question
    else
      render json: @practice_question.errors, status: :unprocessable_entity
    end
  end

 
  def destroy
    @practice_question.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_practice_question
    @practice_question = @course.practice_questions.find(params[:id])
  end

  def authorize_teacher
    unless current_user.user_type == 'teacher'
      render json: { error: 'Only teachers can perform this action' }, status: :forbidden
    end
  end

  def practice_question_params
    params.require(:practice_question).permit(:question, :answer)
  end
end
