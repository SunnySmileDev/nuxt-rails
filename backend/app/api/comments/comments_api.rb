module Comments
    class CommentsApi < BaseApi
      format :json

      before do
        authenticate!
      end

      get do
        Comment.all
      end
   
      params do
        requires :id, type: Integer, desc: "Comments id"
      end
   
      get ':id' do
        begin
          comments = Comment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!({ status: :not_found }, 404)
        end
      end
   
      params do
        requires :id, type: Integer, desc: "Comments id"
      end
   
      delete ':id' do
        begin
          comments = Comment.find(params[:id])
          { status: :success } if comments.delete
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end

      params do
        requires :id, type: Integer, desc: "Comments id"
        requires :post_id, type: Integer, desc: "Comments post_id"
        requires :content, type: String, desc: "Comments content"
        requires :user_id, type: Integer, desc: "Comments user id"
      end
   
      put ':id' do
        begin
          comments = Comment.find(params[:id])
          if comments.update({
                        post_id: params[:post_id],
                        content: params[:content],
                        user_id: params[:user_id]                                
                    })
            { status: :success }
          else
            error!({ status: :error, message: comments.errors.full_messages.first }) if comments.errors.any?
          end
   
   
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end
   
   
      params do
        requires :post_id, type: Integer, desc: "Comments post_id"
        requires :content, type: String, desc: "Comments content"
        requires :user_id, type: Integer, desc: "Comments user id"
     end
   
      post do
        begin
            comment =  Comment.create({
                post_id: params[:post_id],
                content: params[:content],
                user_id: params[:user_id]
            })
          if comment.save
            { status: :success }
          else
            error!({ status: :error, message: comment.errors.full_messages.first }) if comment.errors.any?
          end   
        rescue ActiveRecord::RecordNotFound
          error!({ status: :error, message: :not_found }, 404)
        end
      end
    end
end