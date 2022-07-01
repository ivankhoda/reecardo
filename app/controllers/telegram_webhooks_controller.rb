class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include CallbackQueryAnswerHelper
  # use_session!
  # Every update has one of: message, inline_query, chosen_inline_result,
  # callback_query, etc.
  # Define method with the same name to handle this type of update.
  def show_card(vendor_name)
    user = User.find_by_username(username)
    if !user.nil?
      card = user.cards.find_by_vendor(vendor_name.downcase)
      if card
        barcode = Card.barcode(card.codetype_id, card.code)
        reply_with :photo, photo: barcode

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
            { text: 'Регистрация', callback_data: 'registration' }
          ]
        ]
      }
    end
  end

  def start!(_word = nil, *_other_words)
    reply_with :message, text: 'Добро пожаловать в бот.', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Добавить карточку', callback_data: 'add_new_card' }

        ],
        [
          { text: 'Регистрация', callback_data: 'registration' }
        ],
        [
          { text: 'Найти карточку', callback_data: 'find_card' }
        ]
      ]
    }
  end

  def new_card(*info)
    # data = Struct.new(:vendor, :code) do
    #   def valid?
    #     vendor && code ? true : false
    #   end

    #   def vendor_exists?
    #     !Vendor.find_by_name(vendor).nil?
    #   end
    # end
    # str = data.new(info[0].downcase, info[1])
    # text = str.vendor + str.code
    respond_with :message, text: info
    # if data.valid? && data.vendor_exists?
    #   @vendor = Vendor.find_by_name(data.vendor.downcase)
    #   user_id = User.find_by_username(username).id
    #   card = Card.create({ name: @vendor.name, vendor: @vendor.name, alias: @vendor.alias, code: data.code,
    #                        user_id:, codetype_id: @vendor.codetype_id, vendor_id: @vendor.id })
    #   respond_with :message, text: "Все хорошо, у вас есть карта #{@vendor.name.capitalize}"
    # else
    #   text = 'Введенные вами параметры не подходят, введите название организации и код карточки' unless data.valid?
    #   text = 'Пока что этой организации нет в списке доступных' unless data.vendor_exists?
    #   respond_with :message, text:
    # end
  end

  def callback_query(data)
    username = upd[:callback_query][:from][:username]
    callback_query_answer_handler(data, username)
  end

  def username
    upd[:message][:from][:username]
  end

  def text
    upd[:message][:text]
  end

  def upd
    HashWithIndifferentAccess.new(update)
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
