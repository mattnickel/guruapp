 module API
  module V1
    class PasswordController < Grape::API
      include API::V1::Defaults
      
      resource :passwords do

        get "/forgot" do
          user= User.find_by(email:params[:email])
          if user.present?
           user.generate_password_token! 
            code = user.reset_password_token
            UserMailer.password_reset_email(user, code).deliver
              render json: {
                verification: code,
                status: :ok
              }
          else 
            render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
          end
   
        end

        get "/confirm" do 
          user= User.find_by(reset_password_token:params[:verify])
          if user.present? && user.password_token_valid?
            render json: {status: 'ok'}, status: :ok

          else
            status 400
          end
        end

        put "/reset", :UserSerializer do
          user= User.find_by(reset_password_token:params[:reset])
          if user.present? 
            if user.reset_password!(params[:password])
              user
            else
              status 400
            end
          end
        end
      end
    end
  end
end

 

