module API
  module V1
    class GameScores < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

      resource :game_scores do
        
        desc "Read"
        get do
        end
        
        desc "Create"
        post do
        end
        
        desc "Update"
        post do
          
      end
  end

end
end
end