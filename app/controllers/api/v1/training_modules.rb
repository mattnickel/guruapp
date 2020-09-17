module API
  module V1
    class TrainingModules < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      
      resource :training_modules do
        desc "Return all training module"
          get "", :TrainingModulesSerializer do
            TrainingModule.all
          end

        desc "Return a training module"
          params do
            requires :id, type: String, desc: "id of training module"
          end
          get ":id" do
            TrainingModule.where(id: permitted_params[:id]).first!
          end
      end
    end
  end
end