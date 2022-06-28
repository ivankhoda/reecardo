module CallbackQueryAnswerHelper
  def callback_query_answer_handler(data, username)
    case data
    when 'registration'
      if !User.find_by_username(username).nil?
        respond_with :message, text: 'Вы уже зарегистрированы.'
      else
        User.create({ username: })
        respond_with :message, text: 'Вы успешно зарегистрированы.'
      end

    when 'add_new_card'
      save_context :new_card
      respond_with :message, text: 'Пожалуйста, укажите название магазина и код карточки.'

    else
      reply_with :message, text: 'Not found command'
    end
  end

  private

  def callback_query_message(update)
    HashWithIndifferentAccess.new(update)[:callback_query][:message][:reply_to_message][:text]
  end

  def callback_query_username(update)
    HashWithIndifferentAccess.new(update)[:callback_query][:from][:username]
  end
end
