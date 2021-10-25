module FillMessageSupport
  def fill_message
    fill_in 'message_message', with: 'テスト'
    find('#rating-form').find("img[alt='5']").click
  end
end