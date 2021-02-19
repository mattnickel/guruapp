 module API
  module V1
    class BadPosts < Grape::API
      include API::V1::Defaults
      # include API::V1::Authenticate
      
      resource :bad_posts do
        desc "create bad post record"
        params do
          requires :post_id, type: Integer
          requires :hide_only
        end
        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          post = SocialPost.find_by(id:params[:post_id])
          hide = params[:hide_only]
          if BadPost.create!({user_id: current_user.id, social_post:post, hide_only:hide})
              
              render json: {
                messages: "Post Marked.",
                is_success: true,
                status: :ok
              }
          end
        end

      end 
    end
  end
end