module API
    module V1
        class SocialAttempts < Grape::API
            include API::V1::Defaults
            include API::V1::Authenticate

            resource :social_attempts do
                desc "get"
                get do
                    render json: {
                        message: "GET",
                        is_success: true,
                        status: :ok
                    }
                end

                desc "Create new attempt"
                post do
                    current_user = User.find_by(authentication_token: headers['Token'])
                    save_activity(current_user)
                    if SocialAttempt.create!(user_id: current_user.id, description: "", created_at: Date.today)
                        render json: {
                            messages: "Attempt",
                            is_success: true,
                            status: :ok
                        } 
                    end
                    
                end
            end

        end
    end
end