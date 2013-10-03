=begin
Copyright (C) 2013 Camille_LDN
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
class ArticlesController < ApplicationController
  def index
    if params[:search]
      @articles = Article.search(params)
    else
      @articles = Article.order('published_at DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def updateStatus
    @article = Article.find(params[:id])
    type = params[:type]
    if type == "favourite"
      current_user.favourites << @article
      redirect_to :back, notice: "You favourited #{@article.name}"
    elsif type == "unfavourite"
      current_user.favourites.delete(@article)
      redirect_to :back, notice: "Unfavourited #{@article.name}"
    elsif type == "viewed"
      current_user.viewed << @article
      redirect_to :back, notice: "You viewed #{@article.name}"
    elsif type == "unviewed"
      current_user.viewed.delete(@article)
      redirect_to :back, notice: "Unviewed #{@article.name}"
    else
      redirect_to :back, notice: "Nothing happened."
    end
  end

end
