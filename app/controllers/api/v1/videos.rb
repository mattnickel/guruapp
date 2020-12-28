module API
  module V1
    class Videos < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :videos do
        desc "Return all videos"
        get "", :VideoSerializer do
          Video.all
        end
        get "random" do
          Video.order('RANDOM()').first
        end
        desc "Return a video"
        params do
          requires :id, type: String, desc: "id of video"
        end
        get ":id" do
          Video.where(id: permitted_params[:id]).first!
        end
        
      end
    end
  end
end