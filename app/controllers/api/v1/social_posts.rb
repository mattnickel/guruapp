module API
  module V1
    class SocialPosts < Grape::API
      include API::V1::Defaults
      include API::V1::Authenticate

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
        new_file = ActionDispatch::Http::UploadedFile.new(params[:image])
        group = Group.find_by(name:params[:group])
        puts "group here"
        puts params
        puts group
        save_activity(current_user)
<<<<<<< HEAD
        new_post = SocialPost.create!({image:new_file, message: params[:message], user:current_user, group: group})
        status 200
=======
        if params[:video]
          video = ActionDispatch::Http::UploadedFile.new(params[:video])
          if video
            if params[:group]
              group = Group.find_by(name:params[:group])
            end
            new_post = SocialPost.create!({video: video, message: params[:message], user:current_user, group:group})
            status 200
          else
            status 400
          end
        elsif params[:image]
          image = ActionDispatch::Http::UploadedFile.new(params[:image])
          if image
            if params[:group]
              group = Group.find_by(name:params[:group])
            end
            new_post = SocialPost.create!({image:image, message: params[:message], user:current_user, group:group})
            status 200
          else
            status 400
          end
        else
          status 400
        end

>>>>>>> 45cb39d076df8e74cac364d708c1d700c5c837bc
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