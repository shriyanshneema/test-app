class PostsController < ApplicationController
  before_action :authenticate_user, except: %i(index show)
  before_action :set_post, only: %i(show edit update destroy)

  def index
    @pagy, @posts = pagy(Post.all.includes(:author), items: 5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params.merge(author_id: @current_user.id))

    unless @post.valid?
      flash[:errors] = errors(@post)
      return render :new
    end

    redirect_to post_path(@post), notice: "Created successfully"
  end

  def update
    outcome = @post.update(post_params)

    unless outcome
      flash[:error] = "Something went wrong please try again"
      return render :edit
    end

    redirect_to post_path(@post), notice: "Updated successfully"
  end

  def destroy
    return redirect_to post_path(@post), alert: "Unable to delete has comments" if @post.has_any_comment?

    @post.destroy
    redirect_to posts_path, notice: "Destroyed successfully" if @post.destroyed?
  end

  private
  def post_params
    params[:post][:tag] = params.dig(:post, :tag).to_i
    params.require(:post).permit(:title, :description, :tag)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
