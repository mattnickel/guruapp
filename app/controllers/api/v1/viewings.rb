 module API
  module V1
    class Viewings < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :viewings do
        desc "create viewing record"
        params do
          requires :video_id, type: Integer
          requires :last_second_viewed, type: Integer
          requires :date, type: Date
        end
        post do
          if Viewing.create!({video_id: params[:video_id], user_id: @current_user.id, last_second_viewed: params[:last_second_viewed], date_viewed: params[:date]})
              render json: {
                messages: "Viewing Successfully Saved",
                is_success: true,
                status: :ok
              }
          end
<<<<<<< HEAD
          save_activity(current_user)
=======
        save_activity(current_user)
>>>>>>> 209d3a524fbaa56a8995fe401f6fa2f66ff62557
        end
      end 

      
    end
  end
end