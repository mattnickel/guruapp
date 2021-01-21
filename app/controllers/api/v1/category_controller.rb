module API
  module V1
    class CategoryController < Grape::API
      include API::V1::Defaults
      # include scope
      
      resource :categories do
        desc "Return all categories"
        get "", :CategorySerializer do
          Category.all
        end

     
      end
    end
  end
end