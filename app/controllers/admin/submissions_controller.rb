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
class Admin::SubmissionsController < ApplicationController
  before_filter :superuser_required

  def index
    @submissions = Submission.where(:status => "New")
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def draft_article
  	@submission = Submission.find(params[:id])
    @article = Article.new
    @article.video_link = @submission.url
    @article.description = @submission.description
  end

  def accept
    @article = Article.new(params[:article])
    @submission = Submission.find(params[:id])
    @submission.accept
    if @article.save
      @submission.accept
      SubmissionMailer.submission_accepted(@submission, @article).deliver
      redirect_to admin_submissions_url, notice: 'Article was successfully created.'
    else
      render "draft_article"
    end
  end

  def refuse
  	submission = Submission.find(params[:id])
    submission.refuse
    SubmissionMailer.submission_refused(submission).deliver
    redirect_to admin_submissions_url
  end

end