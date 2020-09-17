module API
  module V1
    module Authenticate
      extend ActiveSupport::Concern
      
      included do
        before do
           error!("401 Unauthorized, bitches", 401) unless authenticate!
        end

        helpers do

          def authenticate!
            current_user = User.find_by(authentication_token: headers['Token'])
            return true if current_user 
          end
        end
      end
    end
  end
end