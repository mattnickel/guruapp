class CommentsSerializer < ActiveModel::Serializer
   attributes :id, :body, :created_at, :username

   def username
   	comment_user = User.find_by(id: object.user_id)
   	username = comment_user.username
    return username
   end
end