class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  include ApplicationHelper

  # GET /posts
  # GET /posts.json
  def index
    if params[:search] || params[:search2]
      @post = Post.search(params[:search],params[:search2]).paginate(:page => params[:page], :per_page => 6)
    else
      @post = Post.paginate(:page => params[:page], :per_page => 6)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def cambios
      
      @post = Post.find(params[:id])
  
      @post.update(estado: !@post.estado)
      puts @post.estado

  end



  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
      
      puts "aaaaaaaaaaaaaaaa"
      @post.attributes = post_params
      puts @post.attributes

      puts "asfdadfdsf"

      puts @post.name
      puts post_params 
      show1(@post)
      if @post.update(@post.attributes)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id]) rescue not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :body, :user_id, :category_id, :estado)
    end
end
