class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :ok }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

# begin Article API
  swagger_controller :articles, "Articles controller API"
 
  swagger_api :index do
    summary "Get Articles list"
    response :ok
  end

  swagger_api :show do
    summary "Get single Article item"
    param :path, :id, :integer, :required, "Article Id"
    response :ok
    response :not_found
  end

  swagger_api :create do
    summary "Create new Article"
    param :form, :title, :string, :required, "Title"
    param :form, :text, :string, "Text"
    param :form, :category_id, :integer, "Category Id"
    response :created
    response :unprocessable_entity
    response :unauthorized
  end

  swagger_api :update do
    summary "Update existing Article"
    param :path, :id, :integer, :required, "Article Id"
    param :form, :title, :string, :required, "Title"
    param :form, :text, :string, "Text"
    param :form, :category_id, :integer, "Category Id"
    response :unauthorized
    response :not_found
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary "Delete existing Article item"
    param :path, :id, :integer, :required, "Article Id"
    response :unauthorized
    response :unprocessable_entity
    response :no_content
  end
# end Article API

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :text, :category_id)
    end
end
