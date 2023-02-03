module UsersHelper
  def user_profile_picture_link(user)
    user.profile_picture.present? ? rails_blob_path(user.profile_picture.variant(:thumb), disposition: "attachment") : "default.jpeg"
  end

end
