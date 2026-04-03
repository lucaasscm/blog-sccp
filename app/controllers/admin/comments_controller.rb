# frozen_string_literal: true

module Admin
  class CommentsController < Admin::BaseController
    def index
      @comments = Comment.includes(:user, :post).order(id: :desc)
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to admin_comments_path, notice: "Comentário removido com sucesso."
    end
  end
end
