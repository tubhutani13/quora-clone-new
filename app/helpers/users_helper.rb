def user_profile_picture_link(user)
    user.profile_picture.present? ? rails_blob_path(user.profile_picture.variant(:thumb), disposition: 'attachment') : 'default.jpeg'
end
def change_password
    current_user.generate_change_password_token
    redirect_to edit_password_reset_url(current_user.password_reset_token)
end
