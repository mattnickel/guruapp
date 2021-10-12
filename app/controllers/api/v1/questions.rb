module API
    module V1
        class Questions < Grape::API
            include API::V1::Defaults
            include API::V1::Authenticate

            resource :questions do
                desc "Get all Question"
                get "", :QuestionsSerializer do
                  Question.all
                end

                desc "Create Question"
                    params do
                        requires :text
                        # requires :offered_response
                    end

                    post do 
                        current_user = User.find_by(authentication_token: headers['Token'])
                        if question = Question.create!({text: params[:text], created_at: DateTime.current})
                            render json: {
                            question_id: question.id,
                            text: question.text,
                            is_success: true,
                            status: :ok
                            }
                        else
                            status 400
                        end
                    end

                desc "Update Question"
                params do
                    requires :text
                    requires :id
                    # requires :offered_response
                end
                put do

                    current_user = User.find_by(authentication_token: headers['Token'])
                    question = Question.find_by(id: params[:id])
                    if question.update({text: params[:text], updated_at: DateTime.current})
                    render json: {
                        question_id: question.id,
                        text: question.text,
                        is_success: true,
                        status: :ok
                    }
                    else
                        status 400
                    end
                end
                


                desc "Delete Question"
                params do
                    requires :id, desc: 'Question ID.'
                end

                delete do

                   if Question.find(params[:id]).destroy
                    render json: {
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