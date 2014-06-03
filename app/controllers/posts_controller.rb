class PostsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index]

	def index
	  @posts = Post.all	
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(params["post"].permit(:title, :description, :picture, ))
		@post.user = current_user

		redirect_to '/posts'
	end

	def destroy
		@post = current_user.posts.find params[:id]
		@post.destroy
		flash[:notice] = 'Post successfully deleted'
	rescue ActiveRecord::RecordNotFound
		flash[:alert] = 'This is not yours to delete!'
	ensure
		redirect_to '/posts'
	end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :description, :picture))
      redirect_to '/posts'
    else
    	flash[:notice] = 'Edits not saved'
      render 'edit'
    end
  end

end
