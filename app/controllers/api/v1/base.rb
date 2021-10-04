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
      mount API::V1::BadPosts
      mount API::V1::BlockedUsers
      mount API::V1::CommentsController
      mount API::V1::GroupsController
      mount API::V1::SocialAttempts
      mount API::V1::GameScores
      mount API::V1::Dashboard
      #mount API::V1::MyChannelView
      mount API::V1::Assessments
      mount API::V1::Questions
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