require "rails_helper"

RSpec.describe PostsController, :type => :controller do
    before(:each) do
        @user = User.create!(email: "aaa@gmail.com", password: "123456123")
        @post = Post.create!(title: "123", content: "12345", user: @user)
    end

	describe 'GET TEST' do  # (almost) plain English
        it 'has a 200 status code' do
            get :index
            expect(response.status).to eq(200)
        end

		it 'get successfully' do   #
			get :index
			expect(response.body).to include @post.to_json
		end

        it 'show successfully' do
            get :show, :params => { id: @post.id }
            expect(response.body).to include "12345"
        end
	end

    describe 'POST TEST' do
        it 'create new post' do
            post :create, :params => { :post => { title: "title", content: "content", user_id: @user.id } }
            expect(response.content_type).to eq "application/json; charset=utf-8"

            get :index
			expect(response.body).to include "title"
            expect(response.body).to include "content"
        end

        it 'update post' do
            put :update, :params => { id: @post.id, :post => { title: "updated_title" } }

            get :index
            expect(response.body).to include "updated_title"
        end
    end
end
