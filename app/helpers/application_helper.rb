module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  # def question_inflect(questions_count)
  #   inflect_for_number(questions_count, 'вопрос', 'вопроса', 'вопросов')
  # end
  #
  # def answer_inflect(answers_count)
  #   inflect_for_number(answers_count, 'ответ', 'ответа', 'ответов')
  # end

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

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
