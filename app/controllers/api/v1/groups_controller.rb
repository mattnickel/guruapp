 module API
  module V1
    class GroupsController < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :groups do
        desc "join person to group"
        params do
          requires :joincode, type: String
        end


        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          group = Group.find_by(joincode:params[:joincode])

          if group == nil
            render json:{
              messages: "Group not found.",
              is_success: false,
              status: :error
            }, status: 500
          elsif group.memberships.create!({user_id: current_user.id})

            render json:{
              group: group.name,
              status: :is_success
            }, status: 200
          else 
            render json:{
              messages: "Already a member.",
              is_success: false,
              status: :error
            }, status: 500
          end
        end
        put do
          current_user = User.find_by(authentication_token: headers['Token'])
          group = Group.find_by(name:params[:group])

          if group
            if current_user.groups.delete(group)
             status 200
           end
          else 
            render json:{
              messages: "Group not removed. Contact support",
              is_success: false,
              status: :error
            }, status: 500
          end
        end
      end 
    end
  end
end