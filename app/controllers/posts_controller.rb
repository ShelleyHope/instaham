class PostsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index]

	def index
	  @posts = Post.all	
	end

	def new
		@post = Post.new
	end

	def create
		Post.create(params["post"].permit(:title, :description, :picture))
		redirect_to '/posts'
	end
end
