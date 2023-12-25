class ProblemsController < InheritedResources::Base

  before_action :set_problem, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update index destroy ]


  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('problems', partial: 'problems/problem', locals: { problem: @problem }),
            turbo_stream.remove('new_problem'),

            turbo_stream.update(
              @problem, 
              partial: 'problems/problem', 
              locals: { problem: @problem }
            ) 
          ]
        end 

        format.html { redirect_to problem_url(@problem), notice: "problem setup was successfully created." }
        format.json { render :show, status: :created, location: @problem }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_problem', partial: 'problems/form', locals: { problem: @problem})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@problem, partial: 'problems/form', locals: { problem: @problem })
      end
    end
  end

  def update
    
    respond_to do |format|
      if @problem.update(problem_params)
        
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              @problem, 
              partial: 'problems/problem', 
              locals: { problem: @problem }
            )
          ]
         
        end

        format.html { redirect_to problem_url(@problem), notice: "problem setup was successfully updated." }
        format.json { render :show, status: :ok, location: @problem }
      else

        format.turbo_stream do 
          render turbo_stream: turbo_stream.update(@problem,
                                                   partial: "problems/form",
                                                   locals: {problem: @problem})
        end
        
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_problem
      @problem = Problem.find(params[:id])
    end
    
    def problem_params
      params.require(:problem).permit(:nom)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
end
