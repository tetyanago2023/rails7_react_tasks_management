# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :check_project_manager, only: [:create, :update]

    def index
      @projects = current_user.projects.order('created_at DESC')
      render json: { projects: @projects.as_json(include: [
                                                   :project_manager,
                                                   :employee,
                                                   {
                                                     tasks: {
                                                       include: [:employee, :project_manager, {
                                                         sub_tasks: {
                                                           include: [:employee, :project_manager]
                                                         }
                                                       }]
                                                     }
                                                   }
                                                 ]) }, status: :ok
    end

    def create
      @project = current_user.projects.build(project_params)

      if @project.save
        render json: { project: @project }, status: :created
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to @project, notice: 'Project was successfully updated.' }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @project.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Project was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def project_params
      params.require(:project).permit(:title, :description, :due_date, :employee_id)
    end
  end
end
