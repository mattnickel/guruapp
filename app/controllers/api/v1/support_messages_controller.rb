 module API
  module V1
    class SupportMessagesController < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :support_messages do
        desc "create new message"
        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          @support_message = SupportMessage.create!({message: params[:message], user: current_user,})
          if @support_message
            UserMailer.support_message(current_user, @support_message.message).deliver

            render json: {
              messages: "Support Message Sent",
              is_success: true,
              status: :ok
            }
          end
        end
      end 

      
    end
  end
end