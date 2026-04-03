# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.published.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @post, notice: "Comentário adicionado."
    else
      redirect_to @post, alert: "Não foi possível adicionar o comentário."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
