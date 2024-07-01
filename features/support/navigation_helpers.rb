module NavigationHelpers
  def path_to(page_name)
    case page_name.downcase
    when 'home'
      root_path
    when 'signup'
      new_user_registration_path
    when 'login'
      new_user_session_path
    when 'account dashboard'
      user_dashboard_path
    when 'personal information'
      personal_information_path
    when 'edit personal information'
      edit_personal_information_path
    when 'digital id'
      digital_id_path
    when 'confirmation'
      confirmation_path
    when 'enter particulars'
      enter_particulars_path
    # Add additional mappings below as needed
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Please add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
