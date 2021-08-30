class BugsController < ApplicationController
  before_action :set_bug, only: %i[ show edit update destroy ]
  before_action :get_project

  # GET /bugs or /bugs.json
  def index
    @bugs = @project.bugs
  end

  # GET /bugs/1 or /bugs/1.json
  def show
    @bug=Bug.friendly.find(params[:id])
  end

  # GET /bugs/new
  def new
    @bug = @project.bugs.build
  end

  # GET /bugs/1/edit
  def edit
  end

  # POST /bugs or /bugs.json
  def create
    @bug = @project.bugs.build(bug_params)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bugs_path(@project), notice: "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        flash[:alert]="Bug couldn't be created."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to project_bug_path(@project), notice: "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        flash[:alert]="Bug couldn't be updated."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to project_bugs_path(@project), notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_project
      @project = Project.friendly.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @project=Project.friendly.find(params[:project_id])
      @bug = @project.bugs.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:title, :description, :types, :status, :project_id)
    end
end
