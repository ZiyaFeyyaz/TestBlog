class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]
  protect_from_forgery

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)

    if user_signed_in?
      @comment.user = current_user
      @comment.save!
    end

    CommentMailer.notify(@article, @comment).deliver

    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: 'Comment was successfully created.' }
      format.json { render json: { notice: 'Comment was successfully created.' }, status: :ok }
    end
  end

  # def update
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @comment }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: 'Comment was successfully destroyed.' }
      format.json { render json: { notice: 'Comment was successfully destroyed.' }, status: :ok }
    end
  end

# begin Comment API
  swagger_controller :comments, "Comments controller API"

  swagger_api :create do
    summary "Create a new Comment"
    param :path, :article_id, :integer, "Article Id"
    param :form, :body, :string, "Comment text"
    response :created
    response :not_found
    response :unprocessable_entity
    response :unauthorized
  end

  # swagger_api :update do
  #   summary "Updates an existing Comment"
  #   param :path, :id, :integer, :required, "Comment Id"
  #   param :form, :body, :text, "Comment text"
  #   param :form, :article_id, :integer, "Article Id"
  #   response :unauthorized
  #   response :not_found
  #   response :unprocessable_entity
  # end

  swagger_api :destroy do
    summary "Delete an existing Comment item"
    param :path, :article_id, :integer, :required, "Article Id"
    param :path, :id, :integer, :required, "Comment Id"
    response :unauthorized
    response :unprocessable_entity
    response :not_found
    response :ok
  end
# end Comment API

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
