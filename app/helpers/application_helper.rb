module ApplicationHelper

  def gravatar(user, size: 100)
    id = Digest::MD5::hexdigest(user.email.downcase)
    path = "https://secure.gravatar.com/avatar/#{id}?s=#{size}&d=mm"
    image_tag(path)
  end

  def show_avatar(user, height, *width)
    if user.picture.blank?
      gravatar(user, size: height)
    else
      if !width.empty?
        height = nil
      end
      image_tag(user.picture, width: width, height: height)
    end
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
