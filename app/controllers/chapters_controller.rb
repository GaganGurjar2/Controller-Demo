class ChaptersController < ApplicationController
 before_action :authenticate_user!
  before_action :set_course
  before_action :set_chapter, only: [:show, :update, :destroy]
  before_action :authorize_teacher, only: [:create, :update, :destroy]

  def index
    if current_user.user_type == 'teacher'
      @chapters = @course.chapters
    elsif current_user.user_type == 'student'
      @chapters = current_user.courses.exists?(@course) ? @course.chapters : []
    end
    render json: @chapters
  end

  
  def create
    @chapter = @course.chapters.build(chapter_params)
    if @chapter.save
      render json: @chapter, status: :created
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

 
  def show
    render json: @chapter
  end


  def update
    if @chapter.update(chapter_params)
      render json: @chapter
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

 
  def destroy
    @chapter.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_chapter
    @chapter = @course.chapters.find(params[:id])
  end

  def authorize_teacher
    unless current_user.user_type == 'teacher'
      render json: { error: 'Only teachers can perform this action' }, status: :forbidden
    end
  end

  def chapter_params
    params.require(:chapter).permit(:name)
  end

end
