module API
  module V1
    class CommentsController < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :comments do
        desc "create new comment"
        params do
          requires :comment, type: String
          requires :post_id, type: Integer
        end
        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          if current_user
            commentable = SocialPost.find_by(id:params[:post_id])
            if commentable.comments.create!(body:params[:comment], user_id:current_user.id)
              render json: {
                messages: "Comment saved.",
                is_success: true,
                status: :ok
              }
            end
            save_activity(current_user)
          end
        end

      end
      
    end
  end
end