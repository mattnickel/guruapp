module API
    module V1
        class Assessments < Grape::API
            include API::V1::Defaults
            include API::V1::Authenticate

            resource :assessments do
                desc "Get all Assessments"
                get "", :AssessmentSerializer do
                  Assessment.all
                end

                desc "Create Assessment"
                    params do
                        requires :assessment_type
                        requires :name
                        #requires :assessment_question
                    end

                post do 
                    current_user = User.find_by(authentication_token: headers['Token'])
                    if @assessment = Assessment.create!({name: params[:name], assessment_type: params[:assessment_type], created_at: DateTime.current})
                        render json: {
                        assessment_id: assessment.id,
                        name: assessment.name,
                        assessment_type: assessment.assessment_type,
                        is_success: true,
                        status: :ok
                        }
                    else
                        status 400
                    end
                end

                # desc "Update Assessment"
                # if assessment.update({name: params[:name], assessment_type: params[:assessment_type], updated_at: DateTime.current})
                #     render json: {
                #         assessment_id: assessment.id,
                #         name: assessment.name,
                #         assessment_type: assessment.assessment_type,
                #         is_success: true,
                #         status: :ok
                #     }
                # else
                #     status 400
                # end


                # desc "Delete Assessment"
                # params do
                #     requires :id, desc: 'Assessment ID.'
                # end

                # delete ':id' do
                #     authenticate!
                #     assessment.find(params[:id]).destroy
                # end
            end

        end
    end
end