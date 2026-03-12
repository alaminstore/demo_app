module Users
  class Show
    def self.call(id)
      user = User.includes(posts: :comments).find(id)

      user.as_json(
        include: {
          posts: {
            include: :comments
          }
        }
      )
    end
  end
end
