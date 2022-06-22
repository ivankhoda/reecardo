class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include CallbackQueryAnswerHelper
  include Telegram::Bot::UpdatesController::MessageContext
  use_session!
  # Every update has one of: message, inline_query, chosen_inline_result,
  # callback_query, etc.
  # Define method with the same name to handle this type of update.
  def message(_message)
    if !User.find_by_username(username).nil?
      card = User.find_by_username(username).cards.find_by_vendor(text.downcase)
      if card
        barcode = Card.barcode(card.codetype_id, card.code)
        reply_with :photo, photo: barcode
        # respond_with :message, text: 'barcode'
      else
        respond_with :message, text: 'Карточка с таким названием не найдена, хотите завести?', reply_markup: {
          inline_keyboard: [
            [
              { text: 'Добавить новую карту', callback_data: 'add_new_card' }
            ]
          ]
        }

      end

    else
      respond_with :message, text: 'Вы не зарегистрированы, сперва нужно зарегистрироваться', reply_markup: {
        inline_keyboard: [
          [
            { text: 'Registration', callback_data: 'registration' }
          ]
        ]
      }
    end
  end

  def start!(_word = nil, *_other_words)
    reply_with :message, text: 'Welcome to bot, please select item...', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Добавить карточку', callback_data: 'add_new_card' },
          { text: 'Показать все мои карточки', callback_data: 'show_user_cards' }
        ]
      ]
    }
  end

  def new_card(*info)
    message = Struct.new(:vendor, :code) do
      def valid?
        vendor && code ? true : false
      end

      def vendor_exists?
        !Vendor.find_by_name(vendor).nil?
      end
    end
    data = message.new(info[0].downcase, info[1])
    p data.vendor_exists?

    # @vendor = Vendor.find_by_name(info[0].downcase)
    # name = @vendor.name
    # ref = @vendor.alias
    # codetype_id = @vendor.codetype_id
    # vendor_id = @vendor.id
    # user_id = User.find_by_username(username).id
    # codetype_id = @vendor.codetype_id
    # code = info[1]
    # card = Card.create({ name:, vendor: name, alias: ref, code:,
    #                      user_id:, codetype_id:, vendor_id: })
    # if card.id
    #   respond_with :message, text: "Все хорошо, у вас есть карта #{@vendor.name.capitalize}"
    # else
    #   respond_with :message, text: ' Что-то пошло не так'
    # end
    respond_with :message, text: ' Что-то пошло не так'
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

  def text
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:text]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
