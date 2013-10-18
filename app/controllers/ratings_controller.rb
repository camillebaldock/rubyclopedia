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
class RatingsController < ApplicationController

  def update
    @rating = Rating.find(params[:id])
    if @rating.stars == 0
      kind_id = Kind.find_by_name('Learner').id
      current_user.change_points({ points: 5, kind: kind_id })
    end
    @article = @rating.article
    if @rating.update_attributes(stars: params[:stars])
      @quality = Rating.where(article_id: @article.id, user_id: current_user.id, kind: 'Quality').first 
      @difficulty = Rating.where(article_id: @article.id, user_id: current_user.id, kind: 'Difficulty').first 
      respond_to do |format|
        format.js
      end
    end
  end

end