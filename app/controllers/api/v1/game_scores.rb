module API
  module V1
    class GameScores < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

      resource :game_scores do
        
        desc "Read"
        params do
          requires :game_type
        end
        get "", :GameScoreSerializer do
          high = GameScore.where(["game_type = :game_type AND updated_at < :today", {game_type: params[:game_type], today: Date.today}]);
          today = GameScore.where(["game_type = :game_type AND updated_at = :today", {game_type: params[:game_type], today: Date.today}]);

          render json: {
            high: high,
            today: today
          }
        end
        
        desc "Create"
        post do
        end
        
        desc "Update"
        
        put do
          current_user = User.find_by(authentication_token: headers['Token'])
          game_score = GameScore.where(["game_type = :game_type AND user_id = :user_id", {game_type: params[:game_type], user_id:current_user.id}])
          new_score = game_score[0].score + params[:score].to_i
          if game_score.update({score: new_score, updated_at: Date.today})
            render json: {
              message: "Success",
              is_success: true,
              status: :ok
            }
          else
            status 400
          end
        end
      end

    end
  end
end