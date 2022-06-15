module CallbackQueryAnswerHelper
  def callback_query_answer_handler(data, username)
    case data
    when 'registration'
      if !User.find_by_username(username).nil?
        respond_with :message, text: 'You already registered'
      else
        User.create({ username: })
        respond_with :message, text: "Congrats, you're in."
      end

    when 'add_new_card'
      save_context :new_card
      respond_with :message, text: 'Пожалуйста, укажите название магазина и код карточки.'
    when 'show_user_cards'
      respond_with :message, text: "Congrats, you're in."
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
