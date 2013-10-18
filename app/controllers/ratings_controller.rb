class RatingsController < ApplicationController

  def update
    @rating = Rating.find(params[:id])
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