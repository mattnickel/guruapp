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
          
        end
      end

    end
  end
end