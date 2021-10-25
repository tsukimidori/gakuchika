module BasicPathSupport
  def basic_path(path)
    username = ENV["BASIC_AUTH_USERNAME"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end
end