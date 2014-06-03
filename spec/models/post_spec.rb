require 'spec_helper'

describe Post do
  describe '#tag_names=' do
    context 'no tags' do
      	it 'does nothing' do
      		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  			login_as user  
	  			post = Post.create(title: 'apple', description: 'fruit', user: user)
      		post.tag_names = ''
      		expect(post.tags).to be_empty
      	end
    end
    context 'one tag' do
    	it 'shows the tag on the post' do
    		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  		login_as user  
	  		post = Post.create(title: 'apple', description: 'fruit', user: user)
    		post.tag_names = 'ace'
    		expect(post.tags.count).to eq 1
    	end
    	it 'prepends the tag with a # if necessary' do
    		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  		login_as user  
	  		post = Post.create(title: 'apple', description: 'fruit', user: user)
    		post.tag_names = 'ace'
    		tag = post.tags.last
    		expect(tag.name).to eq '#ace'
    	end
    	it 'does not add a # if user provided one' do
    		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  		login_as user  
	  		post = Post.create(title: 'apple', description: 'fruit', user: user)
    		post.tag_names = '#cool'
    		tag = post.tags.last
    		expect(tag.name).to eq '#cool'
    	end
    end
    context 'multiple comma-separated tags' do
    	it 'shows the tags on the post' do
    		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  		login_as user  
	  		post = Post.create(title: 'apple', description: 'fruit', user: user)
    		post.tag_names = 'ace,#mad swell, cripes'
    		expect(post.tags.count).to eq 4
    	end
    end
  end
  describe 'reusing a tag' do
  	it 'reuses a tag if it exists' do
  		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  	login_as user  
	  	tag = Tag.create(name: '#great')
	  	post = Post.create(title: 'apple', description: 'fruit', user: user)

    	post.tag_names = 'great'
    	expect(Tag.count).to eq 1

    	expect(tag.posts).to include post			
    end
  end
  	context 'multiple comma-separated tags' do
    	it 'shows only the unique tags on the post' do
    		user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
	  		login_as user  
	  		post = Post.create(title: 'apple', description: 'fruit', user: user)
    		post.tag_names = 'ace,#mad #ace mad'
    		expect(post.tags.count).to eq 2
    	end
    end
end
