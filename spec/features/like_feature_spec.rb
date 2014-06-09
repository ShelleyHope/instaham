require "spec_helper"

describe 'liking posts' do
	before do 
		create(:post) 
		login_as create(:user)
	end
	it 'increments the like count by one' do
		visit '/posts'
		click_link 'G 0'
		expect(page).to have_link 'G 1' 
	end
end