# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :check_project_manager, only: [:create, :update]

    def index
      @projects = current_user.projects.order('created_at DESC')
      render json: { projects: @projects.as_json(include: serializable_attributes) }, status: :ok
    end

    def create
      @project = current_user.projects.build(project_params)

      if @project.save
        render json: { project: @project }, status: :created
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def project_params
      params.require(:project).permit(:title, :description, :due_date, :employee_id)
    end

    def serializable_attributes
      [
        {
          project_manager: {
            except: [:password_digest]
          },
          employee: {
            except: [:password_digest]
          },
          tasks: {
            include: [{
                        employee: {
                          except: [:password_digest]
                        },
                        project_manager: {
                          except: [:password_digest]
                        },
                        sub_tasks: {
                          include: [{
                                      employee: {
                                        except: [:password_digest]
                                      },
                                      project_manager: {
                                        except: [:password_digest]
                                      }
                                    }]
                        }
                      }]
          }
        }
      ]
    end
  end
end
