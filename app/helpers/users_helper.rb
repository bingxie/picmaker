module UsersHelper
  def avatar_for(user, size = 80)
    if user.avatar?
      image_tag user.avatar.url(:thumb), width: size, class: 'avatar-image'
    else
      image_tag 'default-avatar.png', width: size, class: 'avatar-image'
    end
  end
end
