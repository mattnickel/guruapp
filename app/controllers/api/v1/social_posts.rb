module API
  module V1
    class SocialPosts < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate
      # include scope
      
      resource :social_posts do
        desc "Return all posts"
        paginate per_page: 8
        get "", :SocialPostSerializer do
          current_user = User.find_by(authentication_token: headers['Token'])
          bad_post_query = BadPost.where(hide_only: true, user_id: current_user.id).or(BadPost.where(hide_only: false)).pluck(:social_post_id)
          # puts "hi"
          paginate SocialPost.includes(:post_bumps).order(:created_at).reverse_order
          paginate SocialPost.includes(:post_bumps).where.not(id:bad_post_query).order(:created_at).reverse_order

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