module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

      resource :users do
        desc "Return all users"
          get "", :UserSerializer do
            User.all
          end
        desc "Return a user"
          params do
            requires :id, type: String, desc: "ID of the user"
          end
          
          get ":id", :UserSerializer do
            User.where(id: permitted_params[:id]).first!
          end

        desc 'Update a specific user'
       
        put ":id" do
          if params[:avatar]
            # user = User.where(id: permitted_params[:id]).first!
            new_file = ActionDispatch::Http::UploadedFile.new(params[:avatar])
            current_user.update({avatar:new_file})
          else
            current_user.update({ email:params[:email], first_name:params[:first_name], description:params[:description]})
          end
        end
          

        
      end
    #     def update
    #       puts "here"
    #     #   @user = User.find(params[:id])
    #     #   if @user.update_attributes(name: params[:name],
    #     #                   username: params[:username],
    #     #                   email: params[:email],
    #     #                   bio: params[:bio])
    #     #   render json: {
    #     #     message: 'User Updated Successfully',
    #     #     id: @user.id,
    #     #     name: @user.name,
    #     #     username: @user.username,
    #     #     email: @user.email,
    #     #     bio: @user.bio
    #     #   }, status: 200
    #     # else
    #     #   render json: {
    #     #     message: 'Validation Failed',
    #     #     errors: @user.errors.full_messages
    #     #   }, status: 422
    #     # end
    # end

    # def user_params
    #   {
    #     device_token: params[:device_token],
    #     id: params[:id],
    #     name: params[:name],
    #     username: params[:username],
    #     email: params[:email],
    #     bio: params[:bio], 
    #     password: params[:password],
    #     password_confirmation: params[:password_confirmation]
    #   }
    # end
      # def update_user
      #   @user = User.find(params[:id])
      #   if @user.update(user_params)
      #     puts 'the user info successfully updated' #add whatever you want
      #   else
      #     puts 'failed'
      #   end
      # end
    end
  end
end