require 'spec_helper'

describe 'posts index page' do
  context 'logged out' do
    it "does not show the review form" do
      visit '/posts/new'
      expect(page).not_to have_field 'Title'  
    end
  end
  # context 'there are no posts to begin with' do
  #   context 'logged in' do
  #   	it 'displays a welcome message' do
    
  #     	visit '/posts'
  #     	expect(page).to have_content "Welcome to Instaham!"
  # 		end
  #   end
  # end	
end

describe 'adding a post' do
  context 'logged out' do
    it "takes us to the sign up page" do
      visit '/posts/new'
      click_button 'Add your picture or video'

      expect(page).to have_content 'Sign Up'
      
    end

  end

  # context 'logged in' do
  #   it 'adds a post to the index page' do
  #   	visit '/posts/new'
  #   	fill_in 'Title', with: 'Shifie'
  #   	fill_in 'Description', with: "yet another shite selfie"
  #     click_button 'Add your picture or video'

  #   	expect(current_path).to eq '/posts'
  #   	expect(page).to have_content 'Shifie'	
  #   end
  # end
end