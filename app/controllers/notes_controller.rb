class NotesController < ApplicationController
  def update
  	note = ArticleNote.where(:article_id => params[:article_id], :user_id => params["user_id"]).first_or_create
    note.notes = params[:value]
    note.save
    render text: params[:value]
  end
end
