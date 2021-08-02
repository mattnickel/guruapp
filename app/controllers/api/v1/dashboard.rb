module API
    module V1
      class Dashboard < Grape::API
        include API::V1::Defaults
        include API::V1::Authenticate

        resource :dashboard do
            desc "Get dashboard statistic summary"
            get "statistic_summary", :VideoSerializer do
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

            def self.get_stat
                data = Stats.new

                data.active_user_count = UserActivity.where('active_count > 0').count
                data.video_watched_count = Viewing.select('DISTINCT video_id')
                                                    .where('viewings.created_at > ?', Date.today-1.week).count

                most_active_day = UserActivity.select('created_at')
                                                .group('created_at')
                                                .order('SUM(active_count) desc limit 1')
                data.most_active_day = Dashboard.get_weekday_name(most_active_day[0].created_at.wday)

                data.total_user_count = total_users = User.count

                top_3_views = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
                                            .select('videos.id, videos.title, SUM(viewings.last_second_viewed) AS time_viewed')
                                            .where('viewings.created_at > ?', Date.today-1.week)
                                            .group('videos.id, videos.title')
                                            .order('SUM(viewings.last_second_viewed) desc limit 3')
                
                data.top_3_videos = [];
                                            
                top_3_views.each do | viewed_video |
                    video = Video.find(viewed_video.id)
                    data.top_3_videos.push(video.image_file)
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