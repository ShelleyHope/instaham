class PostsController < ApplicationController
	
	def index
	  @posts = Post.all	
	end

	def new
		@post = Post.new
	end

	def create
		Post.create(params["post"].permit(:title, :description))
		redirect_to '/posts'
	end
end
