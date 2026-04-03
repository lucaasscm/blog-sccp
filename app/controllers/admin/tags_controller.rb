# frozen_string_literal: true

module Admin
  class TagsController < Admin::BaseController
    before_action :set_tag, only: %i[edit update destroy]

    def index
      @tags = Tag.order(:title)
    end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        redirect_to admin_tags_path, notice: "Tag criada com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @tag.update(tag_params)
        redirect_to admin_tags_path, notice: "Tag atualizada com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @tag.destroy
      redirect_to admin_tags_path, notice: "Tag removida com sucesso."
    end

    private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:title)
    end
  end
end
