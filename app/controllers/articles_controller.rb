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
class ArticlesController < ApplicationController

  def index
    if params[:search]
      @articles = Article.search(params)
    else
      @articles = Article.order('published_at DESC')
    end
  end

  def show
    @article = Article.find(params[:id])
    if current_user
      @quality = Rating.where(article_id: @article.id, user_id: current_user.id, kind: 'Quality').first 
      @difficulty = Rating.where(article_id: @article.id, user_id: current_user.id, kind: 'Difficulty').first 
      @quality ||= Rating.create(article_id: @article.id, user_id: current_user.id, stars: 0, kind: 'Quality')
      @difficulty ||= Rating.create(article_id: @article.id, user_id: current_user.id, stars: 0, kind: 'Difficulty')
    end
  end

  def updateStatus
    @article = Article.find(params[:id])
    kind_id = Kind.find_by_name('Learner').id
    type = params[:type]
    if type == "favourite"
      current_user.favourites << @article
      current_user.change_points({ points: 1, kind: kind_id })
      redirect_to :back, notice: "You favourited #{@article.name}"
    elsif type == "unfavourite"
      current_user.favourites.delete(@article)
      current_user.change_points({ points: -1, kind: kind_id })
      redirect_to :back, notice: "Unfavourited #{@article.name}"
    elsif type == "viewed"
      current_user.viewed << @article
      current_user.change_points({ points: 1, kind: kind_id })
      redirect_to :back, notice: "You viewed #{@article.name}"
    elsif type == "unviewed"
      current_user.viewed.delete(@article)
      current_user.change_points({ points: -1, kind: kind_id })
      redirect_to :back, notice: "Unviewed #{@article.name}"
    else
      redirect_to :back, notice: "Nothing happened."
    end
  end

end
