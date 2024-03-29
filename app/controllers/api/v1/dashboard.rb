module API
    module V1
      class Dashboard < Grape::API
        include API::V1::Defaults
        include API::V1::Authenticate

        resource :dashboard do
            desc "Get dashboard statistic summary"
            get "statistic_summary" do
                data = Dashboard.get_stat
                
                render json: {
                    active_user_count: data.active_user_count,
                    video_watched_count: data.video_watched_count,
                    most_active_day_week: data.most_active_day,
                    total_system_user: data.total_user_count,
                    top_3_watched_videos: data.top_3_videos,
                    is_success: true,
                    status: :ok
                }
            end

            get "my_most_recent_video" do
                current_user = User.find_by(authentication_token: headers['Token'])
                recent_video = Dashboard.get_my_most_recent_video(current_user.id)

                render json: {
                    recent_video: recent_video,
                    is_success: true,
                    status: :ok
                }
            end

            get "my_most_watched_video" do
                current_user = User.find_by(authentication_token: headers['Token'])

                most_watched_video = Dashboard.get_my_most_watched_video(current_user.id)

                render json: {
                    most_watched_video: most_watched_video,
                    is_success: true,
                    status: :ok
                }
            end

            def self.get_my_most_recent_video(userid)
                recent_video = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
                .select('videos.id AS id, videos.title, videos.author, COUNT(DISTINCT viewings.user_id) AS viewer_count')
                .where("videos.user_id = ?", userid)
                .group('videos.id, videos.title, videos.author')
                .order('videos.created_at desc')
                .first()
                
                if(recent_video)
                    video = Video.find(recent_video.id);
                    my_most_recent_video = ViewedVideo.new                          
                    my_most_recent_video.id = recent_video.id
                    my_most_recent_video.title = recent_video.title
                    my_most_recent_video.author = recent_video.author
                    my_most_recent_video.viewer_count = recent_video.viewer_count
                    my_most_recent_video.thumbnail = video.image
                  return my_most_recent_video
                else
                   return nil
                end
            end

            def self.get_my_most_watched_video(userid)
                watched_video = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
                                .select('videos.id AS id, videos.title, videos.author, COUNT(DISTINCT viewings.user_id) AS viewer_count')
                                .where("videos.user_id = ?", userid)
                                .group('videos.id, videos.title, videos.author')
                                .order('COUNT(DISTINCT viewings.user_id) desc').first()
                                

                if(watched_video)
                    video = Video.find(watched_video.id);

                    my_most_watched_video = ViewedVideo.new

                    my_most_watched_video.id = watched_video.id
                    my_most_watched_video.title = watched_video.title
                    my_most_watched_video.author = watched_video.author
                    my_most_watched_video.viewer_count = watched_video.viewer_count
                    my_most_watched_video.thumbnail = video.image

                    return my_most_watched_video
                else
                    return nil
                end
            end

            def self.get_stat
                data = Stats.new
                today = Date.today

                #For Most Active Day Calculation
                #Monday start of week last week
                start_of_last_week = today.last_week
                #sunday end of last week 
                end_of_last_week =  today.last_week+6.days
                
                


                #Active Users for the day                        
                data.active_user_count = UserActivity.select(:user_id)
                                        .where(["active_count > :active_count and created_at = :created_at",
                                         {active_count: 0, created_at: today}]).uniq.count
                
                # number of Videos Watched (today)       
                data.video_watched_count = Viewing.select('DISTINCT video_id')
                                          .where('viewings.created_at > ?', today).count

                #Most Active Day (Last week)
                #same as weekly stat report
                most_active_day = Stat.where("created_at >= :start_date AND created_at <= :end_date AND description = :description",
                {start_date: start_of_last_week, end_date: end_of_last_week, description:"Number of active users"})
                .limit(1).order("CAST(event_stat AS int) desc , created_at desc") 
                most_active_day.each do |row|
                    record_date = Date.parse(row.day).wday
                    actual_date_int = record_date-1
                    data.most_active_day = Date::DAYNAMES[actual_date_int]
                    
                end
           
                # data.most_active_day = Dashboard.get_weekday_name(most_active_day[0].created_at.wday)
                              
                #Total Users
                data.total_user_count = total_users = User.count

                #Top Videos
                #previous 7 days (not last week)
                top_3_views = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
                                     .select('videos.id AS id, videos.title, videos.author, COUNT(viewings.user_id) AS viewer_count')
                                     .where("viewings.created_at >= :start_date AND viewings.created_at <= :end_date",
                                     {start_date: today-7.days, end_date: today})
                                     .group('videos.id, videos.title, videos.author')
                                     .order('COUNT(viewings.user_id) desc limit 3')
                
                data.top_3_videos = [];
                top_3_views.each do | viewed_video |
                    video = Video.find(viewed_video.id)

                    dashboard_video = ViewedVideo.new                          

                    dashboard_video.id = viewed_video.id
                    dashboard_video.title = viewed_video.title
                    dashboard_video.author = viewed_video.author
                    dashboard_video.viewer_count = viewed_video.viewer_count
                    dashboard_video.thumbnail = video.image
                    data.top_3_videos.push(dashboard_video)
                end

                return data
            end

            def self.get_weekday_name(wday)
                case wday
                when 1
                    return "Monday"
                when 2
                    return "Tuesday"
                when 3
                    return "Wednesday"
                when 4
                    return "Thursday"
                when 5
                    return "Friday"
                when 6
                    return "Saturday"
                else
                    return "Sunday"
                end
            end
        end

      end
    end
end



class Stats
    def active_user_count
        @active_user_count
    end

    def active_user_count= active_user_count
        @active_user_count = active_user_count
    end

    def video_watched_count
        @video_watched_count
    end

    def video_watched_count= video_watched_count
        @video_watched_count = video_watched_count
    end

    def most_active_day
        @most_active_day
    end

    def most_active_day= most_active_day
        @most_active_day = most_active_day
    end

    def total_user_count
        @total_user_count
    end

    def total_user_count= total_user_count
        @total_user_count = total_user_count
    end

    def top_3_videos
        @top_3_videos
    end

    def top_3_videos= top_3_videos
        @top_3_videos = top_3_videos
    end
end

class ViewedVideo
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
end
