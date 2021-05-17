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
          blocked_users = BlockedUser.where(user_id:current_user.id).pluck(:blocked_user_id)
          if params[:group]
            group = Group.find_by(name:params[:group])
            paginate SocialPost.includes(:post_bumps).where(group:group).where.not(id:bad_post_query).where.not(user_id:blocked_users).order(:created_at).reverse_order
          else
            paginate SocialPost.includes(:post_bumps).where(group:nil).where.not(id:bad_post_query).where.not(user_id:blocked_users).order(:created_at).reverse_order
          end
        end

      desc "Create new post"
      post do
        current_user = User.find_by(authentication_token: headers['Token'])
        if params[:image]
          new_media = ActionDispatch::Http::UploadedFile.new(params[:image])
        end
        if params[:media]
          new_media = ActionDispatch::Http::UploadedFile.new(params[:image])
        end
        group = Group.find_by(name:params[:group])
        puts "group here"
        puts params
        puts group
        new_post = SocialPost.create!({image:new_media, message: params[:message], user:current_user, group: group})
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