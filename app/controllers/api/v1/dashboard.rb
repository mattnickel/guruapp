module API
    module V1
      class Dashboard < Grape::API
        include API::V1::Defaults
        include API::V1::Authenticate

        resource :dashboard do
            desc "Get dashboard statistic summary"
            get "statistic_summary" do
                active_users = UserActivity.where('active_count > 0').count

                videos_viewed = Viewing.select('DISTINCT video_id')
                                        .where('viewings.created_at > ?', Date.today-1.week).count

                most_active_day = UserActivity.select('created_at')
                                            .group('created_at')
                                            .order('SUM(active_count) desc limit 1')
                total_users = User.count

                top_3_videos = Viewing.joins("INNER JOIN videos ON videos.id = viewings.video_id")
                                        .select('videos.title, SUM(viewings.last_second_viewed) AS time_viewed')
                                        .where('viewings.created_at > ?', Date.today-1.week)
                                        .group('videos.title')
                                        .order('SUM(viewings.last_second_viewed) desc limit 3')


                render json: {
                    active_user_count: active_users,
                    video_watched_count: videos_viewed,
                    most_active_day_week: Dashboard.get_weekday_name(most_active_day[0].created_at.wday),
                    total_system_user: total_users,
                    top_3_watched_videos: top_3_videos,
                    is_success: true,
                    status: :ok
                }
            end

            def get_weekday_name(wday)
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