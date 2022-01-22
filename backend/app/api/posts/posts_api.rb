module Posts
    class PostsApi < BaseApi
      format :json

      before do
        authenticate!
      end

      get do
        Post.all
      end
   
      params do
        requires :id, type: Integer, desc: "Post id"
      end
   
      get ':id' do
        begin
          post = Post.find(params[:id])
          comments = post.comments.order('id DESC')
          result = {
            post: post,
            comments: comments
          }     
          
        rescue ActiveRecord::RecordNotFound
          error!({ status: :not_found }, 404)
        end
      end
   
      params do
        requires :id, type: Integer, desc: "Post id"
      end
   
      delete ':id' do
        begin
          post = Post.find(params[:id])
          { status: :success } if Post.delete
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end

      params do
        requires :id, type: Integer, desc: "Post id"
        requires :title, type: String, desc: "Post title"
        requires :content, type: String, desc: "Post content"
        requires :user_id, type: Integer, desc: "Post user id"
      end
   
      put ':id' do
        begin
          post = Post.find(params[:id])
          if post.update({
                        title: params[:title],
                        content: params[:content],
                        user_id: params[:user_id]                                
                    })
            { status: :success }
          else
            error!({ status: :error, message: post.errors.full_messages.first }) if post.errors.any?
          end
   
   
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end
   
   
      params do
        requires :title, type: String, desc: "Post title"
        requires :content, type: String, desc: "Post content"
        requires :user_id, type: Integer, desc: "Post user id"
     end
   
      post do
        begin
            post =  Post.create({
                title: params[:title],
                content: params[:content],
                user_id: params[:user_id]
            })
          if post.save
            ActionCable.server.broadcast "post_state_channel", message: "update post"
            { status: :success }
          else
            error!({ status: :error, message: post.errors.full_messages.first }) if post.errors.any?
          end   
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end
    end
end