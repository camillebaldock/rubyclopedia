=begin
Copyright (C) 2013 Camille Baldock
Rubyclopedia is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.
Rubyclopedia is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end
class SubmissionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

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
