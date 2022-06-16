class Card < ApplicationRecord
  belongs_to :user
  has_many :vendors

  def generate_barcode128(num)
    require 'barby'
    require 'barby/barcode/code_128'

    require 'barby/outputter/png_outputter'
    p num
    barcode = Barby::Code128B.new(num)
    png = Barby::PngOutputter.new(barcode).to_png(xdim: 2, ydim: 1)
    IO.binwrite('tmp/barcode.png', png.to_s)
    photo = File.open('tmp/barcode.png')
  end

  def define_codetype(codetype); end

  # def code!(*num)
  #   # some image

  #   # ph = File.open('/Users/ivan/websites/expenses_bot/barcode.svg')
  #   # barcode
  #   image_name = SecureRandom.hex
  #   barcode = Barby::Code128B.new(num[0])
  #   png = Barby::PngOutputter.new(barcode).to_png(xdim: 2, ydim: 1)

  #   # p barcode
  #   # photo = File.write('barcode2.png', png.to_s)
  #   # p photo
  #   # IO.binwrite("tmp/#{image_name}.png", png.to_s)
  #   IO.binwrite('tmp/barcode.png', png.to_s)
  #   photo = File.open('tmp/barcode.png')

  #   respond_with :photo, photo: photo
  # end

  # def code13!(*_num)
  #   require 'barby/barcode/ean_13'
  #   num = '123456789009'
  #   barcode = Barby::EAN13.new(num)
  #   p barcode
  #   png = Barby::PngOutputter.new(barcode).to_png(xdim: 2, ydim: 1)
  #   IO.binwrite('tmp/EANbarcode.png', png.to_s)
  #   photo = File.open('tmp/EANbarcode.png')

  #   respond_with :photo, photo: photo
  # end
end
