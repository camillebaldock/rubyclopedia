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