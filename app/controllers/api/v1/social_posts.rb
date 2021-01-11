module API
  module V1
    class SocialPosts < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      # include scope
      
      resource :social_posts do
        desc "Return all posts"
        get "", :SocialPostSerializer do
          current_user = User.find_by(authentication_token: headers['Token'])
          SocialPost.includes(:post_bumps).all.order(:created_at).reverse_order.limit(20)
        end

      desc "Create new post"
      post do
        current_user = User.find_by(authentication_token: headers['Token'])
        new_file = ActionDispatch::Http::UploadedFile.new(params[:image])
        SocialPost.create!({image:new_file, message: params[:message], user:current_user})
        status 200
      end

      desc "Get recent timestmp"
      get "/recent" do
        post = SocialPost.order(created_at: :desc).first
        post.created_at
      end
    end
    end
  end
end