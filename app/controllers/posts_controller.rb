# frozen_string_literal: true

class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    @posts = Post.published.with_attached_cover_image.includes(:category, :tags)
  end

  def show
    @post = Post.published.with_attached_cover_image.includes(:category, :tags, comments: :user).find(params[:id])
  end
end
