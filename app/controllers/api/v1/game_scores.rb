module API
  module V1
    class GameScores < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

      resource :game_scores do
        
        desc "Create"
        params do
          requires :game_type          
        end

        post do
          current_user = User.find_by(authentication_token: headers['Token'])   
          game_score = GameScore.new
          game_score.user_id = current_user.id
          game_score.game_type = params[:game_type]       
          game_score.score = 0;
          game_score.created_at = DateTime.current
          game_score.save
          save_activity(current_user)

          high = GameScores.get_max_score(params[:game_type]);
          today = GameScores.get_max_score(params[:game_type], true);
          render json: {
            game_id: game_score.id,
            high: high,
            today: today,
            is_success: true,
            status: :ok
          }
        end



        desc "Read"
        params do
          requires :game_type
        end
        get "", :GameScoreSerializer do
          high = GameScores.get_max_score(params[:game_type]);
          today = GameScores.get_max_score(params[:game_type], true);
          save_activity(current_user)
          render json: {
            high: high,
            today: today,
            is_success: true,
            status: :ok
          }
        end
        
        
        
        desc "Update"
        put do
          current_user = User.find_by(authentication_token: headers['Token'])
          game_score = GameScore.find_by(id: params[:game_id])

          if game_score.update({score: params[:score], updated_at: DateTime.current})
            save_activity(current_user)
            high = GameScores.get_max_score(params[:game_type]);
            today = GameScores.get_max_score(params[:game_type], true);

            render json: {
              high: high,
              today: today,
              is_success: true,
              status: :ok
            }
          else
            status 400
          end         
        end


        
        def get_max_score(game_type, today = false)
          if(today)
            sql = "game_type = :game_type AND CAST(game_scores.updated_at as date) = :today";
          else
            sql = "game_type = :game_type AND CAST(game_scores.updated_at as date) != :today";
            # sql = "game_type = :game_type";
          end

          GameScore.joins(:user)
            .where([sql, {game_type: game_type, today: Date.today}])
            .select("users.username", "score")
            .order(score: :desc)
            .first()
        end


        

      end

    end
  end
end