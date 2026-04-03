# frozen_string_literal: true

module Admin
  class PostsController < Admin::BaseController
    before_action :set_post, only: %i[edit update destroy]

    def index
      @posts = Post.includes(:category, :tags).order(id: :desc)
    end

    def new
      @post = Post.new
    end

    def create
      @post = Current.user.posts.new(post_params)

      if @post.save
        redirect_to admin_posts_path, notice: "Post criado com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Post atualizado com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path, notice: "Post removido com sucesso."
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :status, :category_id, :cover_image, tag_ids: [])
    end
  end
end
