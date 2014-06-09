require 'spec_helper'

describe 'tagging posts' do
	let(:user) { create(:user) }
	before do
	  login_as user  
	end 

	it 'displays the tags on the posts home page' do
			visit '/posts/new'
			fill_in 'Title', with: 'mug'
			fill_in 'Description', with: 'what a lovely mug!'
			attach_file 'Picture', Rails.root.join('spec/images/Blue_diamond.png')
			fill_in 'Tags', with: 'ace, fab'
			click_button 'Add my post'

			expect(page).to have_content '#ace'
			expect(page).to have_content '#fab'
		end

		it 'can filter posts by tag' do
	    login_as user 
	    create(:post, user: user, title: 'pic1', tag_names: 'yolo')
	    create(:post, user: user, title: 'pic2', tag_names: 'swag')
			visit '/posts'
			click_link 'yolo'

			expect(page).to have_css 'h2', text: 'Posts tagged with #yolo'
			expect(page).to have_content 'yolo'
			expect(page).not_to have_content 'swag'
		end
end