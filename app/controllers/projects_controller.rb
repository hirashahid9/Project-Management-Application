class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    if current_user.nil?
      redirect_to '/',notice: "Access denied"
    end
    if(current_user && current_user.developer?)
      @projects=policy_scope(Project)
    else
      @projects = Project.all
    end
  end

  # GET /projects/1 or /projects/1.json
  def show

    dev_id=Role.where(name: 'Developer').select(:id)
    qa_id=Role.where(name: 'QA').select(:id)

    @dev=@project.users.where('role_id=?',dev_id)
    @qa=@project.users.where('role_id=?',qa_id)
    
    @project=Project.friendly.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project
  end

  # GET /projects/1/edit
  def edit
  end

  def addmember
    u=UserProject.where('project_id=?',params[:proj_id]).select(:user_id)
    @projusers=u.pluck(:user_id)
    @project=Project.where('id=?',params[:proj_id])


    dev_id=Role.where(name: 'Developer').select(:id)
    qa_id=Role.where(name: 'QA').select(:id)

    @dev=User.where('role_id=?',dev_id[0])
    @qa=User.where('role_id=?',qa_id[0])

  end

  def addall
    p=Project.find(params[:id])
    p.users.clear
    if(params[:dev_ids])
      ids=params[:dev_ids]
      ids.each do |id|
        u = User.find(id)
        p.users << u
      end
    end

    if(params[:qa_ids])
      ids=params[:qa_ids]
      ids.each do |id|
        p.users << User.find(id)
      end
    end

    respond_to do |format|
      format.html { redirect_to p, :notice => 'Members successfully saved' }
    end
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.manager=current_user
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        flash[:alert]="Project couldn't be created."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        flash[:alert]="Project couldn't be updated."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project=Project.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description)
    end
end
