module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def inflect_for_number(number, vopros, voprosa, voprosov)
    number_to_string = number.to_s
    result =
      if number_to_string[-2] == '1' ||
        [*'5'..'9', '0'].include?(number_to_string[-1])
        voprosov
      elsif number_to_string[-1] == '1'
        vopros
      else
        voprosa
      end
  end
end
