class SubmissionsController < ApplicationController
  before_filter :authenticate_user!
  # GET /submissions/new
  # GET /submissions/new.json
  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(params[:submission])
    @submission.status = "New"
    @submission.user_id = current_user.id

    respond_to do |format|
      if @submission.save
        kind_id = Kind.find_by_name('Teacher').id
        current_user.change_points({ points: 10, kind: kind_id })
        format.html { redirect_to :controller => 'users', :action => 'show', :username => current_user.username }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.html { render action: "new" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end
end
