module API
  module V1
    class Viewings < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :viewings do
        desc "create viewing record"
          post do
            @viewing = Viewing.new viewing_params
            if @viewing.save
                render json: {
                  messages: "Viewing Successfully Saved",
                  is_success: true,
                  status: :ok
                }
            end
          end
        end

        private

        def viewing_params
          params.require(:viewing).permit(:video_id, :last_second_viewed, :date)
        end
    end
  end
end