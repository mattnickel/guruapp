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

        desc "Return random video"
        get "random" do
          Video.order('RANDOM()').first
        end

        desc "Return video by category"
        get "category", :VideoSerializer do
          Video.joins(:categories).where(categories: {name: params[:category]})
        end

        desc "Return a video fileby ID"
        params do
          requires :id, type: String, desc: "id of video"
        end
        get ":id"  do
          Video.where(id: permitted_params[:id]).first!
        end
        
        desc "Post new Video"
        params do
          requires :title, type: String
          requires :description, type: String
          requires :author, type: String
          # requires :seconds, type: Integer
          requires :image
          requires :video
        end

        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          save_activity(current_user)
          video = ActionDispatch::Http::UploadedFile.new(params[:video])
          image = ActionDispatch::Http::UploadedFile.new(params[:image])

          new_video = Video.create!({video: video, title: params[:title], description: params[:description], author: current_user, image: image})
        end
      end
    end
  end
end