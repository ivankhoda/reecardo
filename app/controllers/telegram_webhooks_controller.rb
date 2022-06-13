class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  use_session!
  # Every update has one of: message, inline_query, chosen_inline_result,
  # callback_query, etc.
  # Define method with the same name to handle this type of update.
  def message(_message)
    respond_with :message, text: 'We dont know you.'
  end

  def start!(_word = nil, *_other_words)
    reply_with :message, text: 'Welcome to Expenses bot, please select item...', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Add new card', callback_data: 'add_new_card' },
          { text: 'Show my cards', callback_data: 'show_user_cards' }
        ]
      ]
    }
  end

  private

  def username
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:from][:username]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
