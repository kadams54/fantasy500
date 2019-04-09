module UsersHelper
  def gravatar_for(user, size: 64)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    initials = user.name.split(" ").map {|n| n[0].capitalize }.join("")
    image_tag(gravatar_url, alt: user.name, class: "avatar avatar-xl", data: {initial: initials})
  end
end
