require 'spec_helper'

describe 'posts index page' do
  context 'logged out' do
    it "does not show the review form" do
      visit '/posts/new'
      expect(page).not_to have_field 'Title'  
    end
  end
  context 'there are no posts to begin with' do
    context 'logged in' do
    	it 'displays a welcome message' do
    
      	visit '/posts'
      	expect(page).to have_content "Welcome to Instaham!"
  		end
    end
  end	
end

describe 'adding a post' do
  context 'logged out' do
    it "takes us to the sign up page" do
      visit '/posts/new'

      expect(page).to have_content 'Sign up'
      
    end

  end

  context 'logged in' do
    it 'adds a post to the index page' do
      visit '/users/sign_up'
      fill_in 'Email', with: 'abc@c.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button 'Sign up'

      visit '/posts/new'
    	fill_in 'Title', with: 'New Shifie'
    	fill_in 'Description', with: "Yet another shite selfie"
      attach_file 'Picture', Rails.root.join('spec/images/Blue_diamond.png')
      click_button 'Add your post'

    	expect(current_path).to eq '/posts'
    	expect(page).to have_content 'New Shifie'	
      expect(page).to have_css 'img.uploaded_picture'
    end
  end
end