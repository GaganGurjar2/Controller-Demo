class CoursesController < ApplicationController
	before_action :authenticate_user!
	def index 
		if current_user.user_type == 'teacher'
			@courses = current_user.courses
	   elsif current_user.user_type == 'student'
	   	@courses =Courses.all
	   end 
	   render json: @courses
  end

   def create
            if current_user.user_type == 'teacher'
            @course =current_user.courses.build(course_params)
            if @course.save
              render json: @course, status: :created
              else
              render json: @course.errors, status: :unprocessable_entity
              end 

            else
             render json: {error: 'Only teacher can create courses'},status: :forbidden
       end 
   end 
def show
	@course =Course.find(params[:id])
     render json: @course
 end 
  
  def update
  	@course =Course.find(params[:id])
  	if @course.update(course_params)
  		render json: @course
  	else
  	render json: @course.errors, status: :unprocessable_entity
  	end 	
  end  
  def destroy 
  	@course = Course.find(params[:id])
  	@course.destroy
  	head :no_content
end 
private
 def course_params
 	params.require(:course).premit(:title, :description, :user_type)
 end
end

