require 'spec_helper'

describe 'tagging posts' do
	before do
	  user = create(:user)
	  login_as user  
	end 
		it 'displays the tags on the posts home page' do
			visit 'posts/new'
			fill_in 'Title', with: 'mug'
			fill_in 'Description', with: 'what a lovely mug!'
			attach_file 'Picture', Rails.root.join('spec/images/Blue_diamond.png')
			fill_in 'Tags', with: 'ace, fab'
			click_button 'Add my post'

			expect(page).to have_content '#ace'
			expect(page).to have_content '#fab'
		end
end