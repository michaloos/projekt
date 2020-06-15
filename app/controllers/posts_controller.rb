class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_before_show, only: [:show]



  # GET /posts
  # GET /posts.json


  def index
    if params[:category_ids] && params[:location_id]
      @posts=Post.joins(:categories).where("categories.id = ? AND location_id = ?", params[:category_ids], params[:location_id])
      @posts = @posts.order(created_at: :DESC).uniq.paginate(:page => params[:page], :per_page => 3)
    elsif params[:category_ids]
      @posts = Post.joins(:categories).where('categories.id' =>  params[:category_ids])
      @posts = @posts.order(created_at: :DESC).uniq.paginate(:page => params[:page], :per_page => 3)

    elsif params[:location_id]
      @posts = Post.where( location_id: params[:location_id])
      @posts = @posts.order(created_at: :DESC).uniq.paginate(:page => params[:page], :per_page => 3)

    elsif params[:year]
      @posts= Post.where("YEAR(created_at) = ?", year)
      @posts = @posts.order(created_at: :DESC).uniq.paginate(:page => params[:page], :per_page => 3)

    elsif params[:keyword]
      @posts = Post.where('true')
      @posts = @posts.where('lower (title) like', "%#{params[:keywords]}%")
      @posts = @posts.order(created_at: :DESC).uniq.paginate(:page => params[:page], :per_page => 3)
    else
      @posts = Post.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 3)
    end
  end



  def authenticate_before_show
    return if post.public?
    realm = "post-#{post.id}"
    authenticate_or_request_with_http_basic(realm) do |username, password|
      post.authenticate(password)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("created_at DESC")
  end

  # GET /posts/new
  def new
    @post = Post.new(user_blog_id: params[:user_blog_id])
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_blog_post_path(user_blog_id: @post.user_blog_id, id:@post.id), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_blog_post_path(user_blog_id: @post.user_blog_id, id:@post.id), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.where(post_id: @post.id)
    @comment.each do |comment|
      comment.destroy
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_blog_path( id: @post.user_blog_id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_blog_id, :password, :location_id, :title, :content, :image, { category_ids:[] })
    end

    def post
      @post = Post.find(params[:id])
    end

end
