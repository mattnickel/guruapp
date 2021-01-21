module API
  module V1
    class Base < Grape::API

      mount API::V1::Users
      mount API::V1::Videos
      mount API::V1::TrainingModules
      mount API::V1::Viewings
      mount API::V1::SocialPosts
      mount API::V1::PostBumps
      mount API::V1::PasswordController
      mount API::V1::SupportMessagesController
      mount API::V1::CategoryController

      helpers do
        def authenticate!
          error!('Unauthorized. Invalid or expired token.', 401) unless current_user
        end

        def current_user
           # find token. Check if valid.
          token = ApiKey.where(access_token: params[:token]).first
          if token && !token.expired?
            @current_user = User.find(token.user_id)
          else
            false
          end
        end
      end

    end
  end
end