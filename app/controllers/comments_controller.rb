class CommentsController < ApplicationController
  before_action :authenticate_user, except: %i(index show)
  before_action :set_post, only: %i(new create index)
  before_action :set_comment, only: %i(show edit update destroy)

  def index
    @comments = @post.comments
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.create(comments_params.merge(author_id: @current_user.id))

    unless @comment.valid?
      flash[:errors] = errors(@comment)
      return render :new
    end

    redirect_to comment_path(@comment), notice: "Created Successfully"
  end

  def update
    outcome = @comment.update(comments_params)

    unless outcome
      flash[:error] = "Something went wrong please try again"
      return render :edit
    end

    redirect_to comment_path(@comment), notice: "Updated Successfully"
  end

  def destroy
    @comment.destroy

    redirect_to post_comments_path(@comment.post_id), notice: "Destroyed Successfully" if @comment.destroyed?
  end

  private
  def comments_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
end
