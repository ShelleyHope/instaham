class LikesController < ApplicationController
	def create
		@post = Post.find params[:post_id]
		
		@post.likes.create

# line 5 could also be written as: Like.create(:post @post) or
# 
# like = Like.new
# like.post = @post

		redirect_to '/posts'
	end
end
