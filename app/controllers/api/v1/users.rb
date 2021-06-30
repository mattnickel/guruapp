module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

      resource :users do
        
        desc "Return a user"
          params do
            requires :id, type: Integer, desc: 'User ID'
          end
        route_param :id do
          get do
            user = User.with_pk!(params[:id])
            render user
          end
        end

        desc "Return all users"
          get "", :UserSerializer do
            User.all
          end

        desc 'Update a specific user'
       
        put ":id", :UserSerializer do
          if params[:avatar]
            # user = User.where(id: permitted_params[:id]).first!
            new_file = ActionDispatch::Http::UploadedFile.new(params[:avatar])
            update = current_user.update({avatar:new_file})
            render current_user
          else
            if params[:email] != '' && params[:username] != '' 
              current_user.update({ email:params[:email].strip, username:params[:username].strip, description:params[:description].strip})
              status 200
            else
              status 400
            end
          end
        end
      end
    end
  end
end