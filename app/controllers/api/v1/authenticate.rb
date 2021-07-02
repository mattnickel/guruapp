module API
  module V1
    module Authenticate
      extend ActiveSupport::Concern
      
      included do
        before do
           error!("401 Unauthorized", 401) unless authenticate!
        end

        helpers do

          def current_user
            @current_user ||= User.find_by(authentication_token: headers['Token'])
          end

          def authenticate!
            return true if current_user 
          end

          def save_activity(current_user)
            if UserActivity.exists?(user_id:current_user.id) 
              user_activity = UserActivity.find_by(user_id:current_user.id)
              user_activity.active_count += 1;
              user_activity.created_at = Date.today
              user_activity.save

              user_activity_calculations = UserActivity.find_by(user_id:current_user.id)
              user_activity_calculations.active_count += 1;
              user_activity_calculations.created_at = Date.today
              user_activity_calculations.save 


            else 
              user_activity = UserActivity.new
              user_activity.user_id = current_user.id
              user_activity.active_count = 1;
              user_activity.created_at = Date.today
              user_activity.save

              user_activity_calculations = UserActivity.new
              user_activity_calculations.user_id = current_user.id
              user_activity_calculations.active_count = 1;
              user_activity_calculations.created_at = Date.today
              user_activity_calculations.save
            end
          end

        end
      end
    end
  end
end