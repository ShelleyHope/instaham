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
    before do
      user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      login_as user
    end

    it 'adds a post to the index page' do
      visit '/posts/new'
    	fill_in 'Title', with: 'New Shifie'
    	fill_in 'Description', with: 'Yet another shite selfie'
      attach_file 'Picture', Rails.root.join('spec/images/Blue_diamond.png')
      click_button 'Add your post'

    	expect(current_path).to eq '/posts'
    	expect(page).to have_content 'New Shifie'	
      expect(page).to have_css 'img.uploaded_picture'
    end
  end
end

describe 'deleting a post' do
  context 'my post' do
    before do
      user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      login_as user
      Post.create(title: 'thing', description: 'a lovely thing', user: user)
    end

    it 'removes the post from the posts index page' do
      visit '/posts'
      click_link 'Delete'
      expect(page).to have_content 'Post successfully deleted'
    end
  end

  context 'post belonging to another user' do
    before do
      bill = User.create(email: 'bill@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      ted = User.create(email: 'ted@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      Post.create(title: 'bill', description: 'super', user: bill)
      login_as ted
    end

    it "it doesn't display the delete link" do
      visit '/posts'
      visit '/posts'
      expect(page).not_to have_link 'Delete'
    end
  end  
end

describe 'editing a post' do
  context 'my post' do
  context 'valid data' do
    before do
      user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      login_as user
      Post.create(title: 'thing', description: 'a lovely thing', user: user)
    end
      it 'saves the edited post' do
        visit '/posts'
        click_link 'Edit post'
        fill_in 'Title', with: 'Edited thing'
        fill_in 'Description', with: 'a lovelier thing'
        attach_file 'Picture', Rails.root.join('spec/images/Blue_diamond.png')
        
        click_button 'Confirm edits'
        expect(current_path).to eq '/posts'
        expect(page).to have_content 'Edited thing'
      end
    end
    context 'invalid data' do
      before do
        user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
        login_as user
        Post.create(title: 'thing', description: 'a lovely thing', user: user, id: 23 )
      end
        it 'generates an error message' do
          visit '/posts'
          click_link 'Edit post'
          fill_in 'Title', with: ' '
          click_button 'Confirm edits'
          expect(page).to have_content 'error'
          expect(current_path).to eq '/posts/23'
        end
    end
  end

  context "someone else's post" do
    before do
      me = User.create(email: 'me@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      user = User.create(email: 'a@a.com', password: 'qwertyui', password_confirmation: 'qwertyui')
      login_as user
      Post.create(title: 'thing', description: 'a lovely thing', user: me)
    end

    it "doesn't display the edit link" do
      visit '/posts'
      expect(page).not_to have_link 'Edit post'
    end 
  end
end