 module API
  module V1
    class BlockedUsers < Grape::API
      include API::V1::Defaults
      # include API::V1::Authenticate
      
      resource :blocked_users do
        desc "create blocked user record"
        params do
          requires :blocked_user_id, type: Integer
        end
        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          blocked = params[:blocked_user_id]
          if BlockedUser.create!({user_id: current_user.id, blocked_user_id:blocked})
              
              render json: {
                messages: "User Blocked.",
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