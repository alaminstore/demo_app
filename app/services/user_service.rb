class UserService
  def self.show(id)
    user = User.includes(posts: :comments).find(id)

    user.as_json(
      include: {
        posts: {
          include: :comments
        }
      }
    )
  end

  def self.create(attrs)
    user = User.new(attrs)

    if user.save
      { ok: true, user: user }
    else
      { ok: false, errors: user.errors.full_messages }
    end
  end
end
