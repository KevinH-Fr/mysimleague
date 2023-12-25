class ProblemSecondsController < InheritedResources::Base

  before_action :set_problem_second, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update index destroy ]

  def create
    @problem_second = ProblemSecond.new(problem_second_params)

    respond_to do |format|
      if @problem_second.save

          format.html { redirect_to problems_url(), notice: "Probleme second was successfully created." }
          format.json { render :show, status: :created, location: @problem_second }
      else


        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem_second.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@problem_second, partial: 'problem_seconds/form', locals: { problem_second: @problem_second })
      end
    end
  end

  def update
    
    respond_to do |format|
      if @problem_second.update(problem_second_params)
        
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              @problem_second, 
              partial: 'problem_seconds/problem_second', 
              locals: { problem_second: @problem_second }
            )
          ]
         
        end

        format.html { redirect_to problem_second_url(@problem_second), notice: "problem_second setup was successfully updated." }
        format.json { render :show, status: :ok, location: @problem_second }
      else

        format.turbo_stream do 
          render turbo_stream: turbo_stream.update(@problem_second,
                                                   partial: "problem_seconds/form",
                                                   locals: {problem_second: @problem_second})
        end
        
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @problem_second.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_problem_second
      @problem_second = ProblemSecond.find(params[:id])
    end
    
    def problem_second_params
      params.require(:problem_second).permit(:problem_id, :nom)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
end
