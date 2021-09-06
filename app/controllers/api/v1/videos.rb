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
        
        desc "Post a new Video"
        params do
          requires :title, type: String
          requires :description, type: String
          requires :video
          optional :image
          optional :seconds, type: Integer
          optional :social_image
        end
        post do
          current_user = User.find_by(authentication_token: headers['Token'])
          author = current_user.username
          save_activity(current_user)
          video = ActionDispatch::Http::UploadedFile.new(params[:video])
          image = ActionDispatch::Http::UploadedFile.new(params[:image])


          if video = Video.create!(user_id: current_user.id, video: video, image: image,  title: params[:title], description: params[:description], author: author, created_at: DateTime.current)
          render json: {
              is_success: true,
              user: current_user.username,
              status: :ok,
              video: video
            }
          end
        end


        desc "Edit Video Details"
        params do
          
          optional :image
          optional :social_image
          optional :title
          optional :description
        end
        
        put do 
          current_user = User.find_by(authentication_token: headers['Token'])
          video = Video.where(id: params[:id], user_id: current_user.id)

          if video.update(title: params[:title], description: params[:description], updated_at: DateTime.current)
            save_activity(current_user)
            render json: {
                is_success: true,
                status: :ok,
                message: "Video Details Updated",
                video: video
              }
          end
        end

          desc 'Delete Video'
          params do
            requires :id
          end
          delete do
            current_user = User.find_by(authentication_token: headers['Token'])
            video = Video.where(id: params[:id], user_id: current_user.id)

            if video.find(params[:id]).destroy
              save_activity(current_user)
              render json: {
                is_success: true,
                status: :ok,
                message: "Video Succefully Deleted"
              }
            end
          end




        end
    end
  end
end