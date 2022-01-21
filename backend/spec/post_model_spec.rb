require "rails_helper"

RSpec.describe 'Post' do           #
	before(:each) do
		@user = User.create!(email: "aaa@gmail.com", password: "123456123")
		@post = Post.create!(title: "123", content: "", user: @user)
	end

	describe 'before publication' do  # (almost) plain English
		it 'create successfully' do   #
			expect(Post.count).to eq(1)  # test code
		end

		it 'show works well' do   #
			expect(Post.where(id: @post.id).count).to eq(1)  # test code
		end

		it 'update test' do
			@post.title = "12345"
			@post.save!
			
			expect(@post.title).to eq("12345")
		end
	end
end
