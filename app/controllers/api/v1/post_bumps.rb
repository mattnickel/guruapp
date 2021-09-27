 module API
  module V1
    class PostBumps < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :post_bumps do
        desc "create bump record"
        params do
          requires :bump, type: String
        end
        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          post = SocialPost.find_by(id:params[:postId])
          if PostBump.create!({bump: params[:bump], user_id: current_user.id, social_post:post  })
              render json: {
                messages: "Bump Successfully Saved",
                is_success: true,
                status: :ok
              }
          end
          save_activity(current_user)
        end
        desc "Return all bumps"
        get "" do
          PostBump.all
        end

        desc "Update specific bump"
        
        put do
          current_user = User.find_by(authentication_token: headers['Token'])
          bump = PostBump.where(user:current_user, social_post: params[:post_id]).first!
          status = ActiveModel::Type::Boolean.new.cast(bump:params[:bump])
          if bump.update({bump: false})
             render json: {
              messages: "Bump Successfully Unbumped",
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