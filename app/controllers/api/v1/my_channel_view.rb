module API
  module V1
    class MyChannelView < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

      resource :my_channel_view do
          desc "Get published videos"
          get "my_published_videos" do
            current_user = User.find_by(authentication_token: headers['Token'])
            published_videos = MyChannelView.get_my_published_videos(current_user.id)
              
            render json: {
                my_published_videos: published_videos.video_list,
                is_success: true,
                status: :ok
            }
          end


          def self.get_my_published_videos(userid)
            published_videos = VideoList.new
            my_published_videos = Video.left_outer_joins(:viewings).select('videos.id AS id, videos.title, videos.author, COUNT(DISTINCT viewings.user_id) AS viewer_count')
            .where("videos.user_id = ?", userid)
            .group('videos.id, videos.title, videos.author')
            .order('videos.created_at desc')

            # my_published_videos = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
            # .select('videos.id AS id, videos.title, videos.author, COUNT(DISTINCT viewings.user_id) AS viewer_count')
            # .where("videos.user_id = ?", userid)
            # .group('videos.id, videos.title, videos.author')
            # .order('videos.created_at desc')

            published_videos.video_list = [];
            my_published_videos.each do |video_entry|
                video = Video.find(video_entry.id) 
            
                my_video = PublishedVideo.new
                my_video.id = video.id
                my_video.title = video.title
                my_video.author = video.author
                my_video.viewer_count = video_entry.viewer_count
                my_video.thumbnail = video.image
                my_video.record = video
                published_videos.video_list.push(my_video)
                
            end
                
                return published_videos

            end 
        end
    end
  end
end

class VideoList
    def video_list
        @video_list
    end

    def video_list= video_list
        @video_list = video_list
    end

end


class PublishedVideo
  def id
      @id
  end
  def id= id
      @id = id
  end

  def title
      @title
  end

  def title= title
      @title = title
  end
  def author
      @author
  end
  
  def author= author
      @author = author
  end
  def viewer_count
      @viewer_count
  end
  
  def viewer_count= viewer_count
      @viewer_count = viewer_count
  end
  def thumbnail
      @thumbnail
  end
  
  def thumbnail= thumbnail
      @thumbnail = thumbnail
  end

  def record
    @record
  end

  def record= record
     @record = record
  end
end
