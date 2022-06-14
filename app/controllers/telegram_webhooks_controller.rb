class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include CallbackQueryAnswerHelper
  include Telegram::Bot::UpdatesController::MessageContext
  use_session!
  # Every update has one of: message, inline_query, chosen_inline_result,
  # callback_query, etc.
  # Define method with the same name to handle this type of update.
  def message(message)
    upd = HashWithIndifferentAccess.new(message)
    if !User.find_by_username(username).nil?
      reply_with :message, text: 'Welcome to cardholder, what you like to do?', reply_markup: {
        inline_keyboard: [
          [
            { text: 'Add new card', callback_data: 'add_new_card' },
            { text: 'Show my cards', callback_data: 'show_user_cards' },
            { text: 'Find card', callback_data: 'find_user_card' }
          ]
        ]
      }
    else
      respond_with :message, text: 'Try to reg first', reply_markup: {
        inline_keyboard: [
          [
            { text: 'Registration', callback_data: 'registration' }
          ]
        ]
      }
    end
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

  def new_card(info)
    @vendor = Vendor.find_by_name(info.downcase)
    name = @vendor.name.capitalize
    ref = @vendor.alias
    codetype_id = @vendor.codetype_id
    vendor_id = @vendor.id
    user_id = User.find_by_username(username).id
    codetype_id = @vendor.codetype_id

    card = Card.new({ name:, vendor: @vendor.name, alias: ref,
                      user_id:, codetype_id: })
    p card
    # save_context :new_card_number
    # respond_with :message, text: "Введите номер вашей карты #{@vendor.name.capitalize}"
  end

  def new_card_number(num)
    # p User.find_by_username(username).cards
    p num, 'number'
  end

  def callback_query(data)
    upd = HashWithIndifferentAccess.new(update)
    username = upd[:callback_query][:from][:username]
    callback_query_answer_handler(data, username)
  end

  def username
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:from][:username]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
