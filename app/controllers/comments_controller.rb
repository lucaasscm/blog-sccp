# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[edit update destroy]
  before_action :require_owner, only: %i[edit update destroy]

  def edit
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @post, notice: "Comentário adicionado."
    else
      redirect_to @post, alert: "Não foi possível adicionar o comentário."
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comentário atualizado."
    else
      redirect_to @post, alert: "Não foi possível atualizar o comentário."
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove("comment_#{@comment.id}"),
            turbo_stream.update("comments-count", "(#{@post.comments.count})")
          ]
        end
      format.html { redirect_to @post, notice: "Comentário excluído." }
    end
  end

  private

  def set_post
    @post = Post.published.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def require_owner
    unless @comment.user == Current.user || Current.user.admin?
      redirect_to @post, alert: "Você não tem permissão para isso."
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
