# frozen_string_literal: true

class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    @posts = Post.published.includes(:category, :tags)
  end

  def show
    @post = Post.published.includes(:category, :tags, comments: :user).find(params[:id])
  end
end
