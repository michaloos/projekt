class UserBlogsController < ApplicationController
  before_action :set_user_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /user_blogs
  # GET /user_blogs.json
  def index
    @user_blogs = UserBlog.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 3)
  end

  def your
    @user_blogs = current_user.user_blogs.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 3)
  end

  # GET /user_blogs/1
  # GET /user_blogs/1.json
  def show
    @user_blog = UserBlog.find(params[:id])
    @user= @user_blog.user
  end

  # GET /user_blogs/new
  def new
    @user_blog = current_user.user_blogs.build
  end


  # GET /user_blogs/1/edit
  def edit
  end

  # POST /user_blogs
  # POST /user_blogs.json
  def create
    @user_blog = current_user.user_blogs.build(user_blog_params)

    respond_to do |format|
      if @user_blog.save
        format.html { redirect_to @user_blog, notice: 'User blog was successfully created.' }
        format.json { render :show, status: :created, location: @user_blog }
      else
        format.html { render :new }
        format.json { render json: @user_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_blogs/1
  # PATCH/PUT /user_blogs/1.json
  def update
    respond_to do |format|
      if @user_blog.update(user_blog_params)
        format.html { redirect_to @user_blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_blog }
      else
        format.html { render :edit }
        format.json { render json: @user_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_blogs/1
  # DELETE /user_blogs/1.json
  def destroy
    @user_blog = UserBlog.find(params[:id])
    @post = @user_blog.posts.where(user_blog_id: @user_blog.id)
    @post.each do |post|
      @comment = post.comments.where(post_id: post.id)
      @comment.each do |comment|
        comment.destroy
      end
      post.destroy
    end
    @user_blog.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_blog
      @user_blog = UserBlog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_blog_params
      params.require(:user_blog).permit(:user_id, :name)
    end

  def correct_user
    @user_blog = current_user.user_blogs.find_by(id: params[:id])
    redirect_to root_path, notice: "You don't have permission to edit this blog" if @user_blog.nil?
  end
end
