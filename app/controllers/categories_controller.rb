class CategoriesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  protect_from_forgery

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { render json: { success: true }, status: :ok }
    end
  end

# begin Category API
  swagger_controller :categories, "Categories controller API"
 
  swagger_api :index do
    summary "Get Categories list"
    response :ok
  end

  swagger_api :show do
    summary "Get single Category item"
    param :path, :id, :integer, :required, "Category Id"
    response :ok
    response :not_found
  end

  swagger_api :create do
    summary "Create new Category"
    param :form, :name, :string, :required, "Name"
    response :created
    response :unprocessable_entity
    response :unauthorized
  end

  swagger_api :update do
    summary "Update existing Category"
    param :path, :id, :integer, :required, "Category Id"
    param :form, :name, :string, :required, "Name"
    response :unauthorized
    response :not_found
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Delete existing Category item"
    param :path, :id, :integer, :required, "Category Id"
    response :ok
    response :unauthorized
    response :unprocessable_entity
  end
# end Category API

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
