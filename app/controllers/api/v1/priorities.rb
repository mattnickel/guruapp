 module API
  module V1
    class Priorities < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :priorities do
        desc "create priorities"
        # params do
        #   requires :last_second_viewed, type: Integer
        #   requires :date, type: Date
        # end
        # post do
        #   create_priorities(params)
        #   if Priorities.create!({goals: params[ ], params[0], params)
        #       render json: {
        #         messages: "Priorities Successfully Saved",
        #         is_success: true,
        #         status: :ok
        #       }
        #   end
        # end
      end 

      private
      def create_priorities
          # params.each do 

      end
    end
  end
end