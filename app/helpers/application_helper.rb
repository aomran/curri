module ApplicationHelper

  def link_to_selected(*arg, &block)
    if current_page?(arg[0]) || at_track?(arg[0]) || at_classroom?(arg[0]) || at_account?(arg[0])
      options = arg.extract_options!
      options[:class] += ' selected'
      arg << options
    end

    link_to(*arg, &block)
  end

  def at_classroom?(path)
    path.match(/classrooms$/) && (params[:controller] == 'classrooms' || params[:controller] == 'invitations' || params[:controller] == 'requesters')
  end

  def at_track?(path)
    path.match(/tracks$/) && (params[:controller] == 'tracks' || params[:controller] == 'checkpoints')
  end

  def at_account?(path)
    path == '' && params[:controller] == 'users'
  end

  def current_page_header
    if params[:controller] == 'users'
      'Account'
    elsif params[:controller] == 'sessions' || params[:controller] == 'password_resets'
      ''
    elsif params[:controller] == 'teachers'
      'Register'
    else
      params[:controller].capitalize
    end
  end

  def js_render_user(user)
    javascript_tag %Q{
      window.Curri = {};
      window.Curri.user = #{user.to_json};
    }
  end

  def mixpanel_track(event_name, properties=nil)
    p = properties.nil? ? "" : ", #{properties.to_json}"
    javascript_tag %Q{mixpanel.track("#{event_name}"#{p});}
  end

end
