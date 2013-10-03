class RaterController < ApplicationController 
  
  def create                                  
    if current_user
      article = Article.find(params[:id])     
      params[:dimension] ||= 5
      article.rate params[:score].to_i, current_user.id, "#{params[:dimension]}"       
      render :json => true 
    else
      render :json => false        
    end
  end                                        
  
  
end