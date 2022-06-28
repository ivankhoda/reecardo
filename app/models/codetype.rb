class Codetype < ApplicationRecord
  def self.print_code(codetype_id, value)
    codetype = find_by_id(codetype_id).alias
    generate_code(codetype, value)
  end

  def self.generate_code(codetype, value)
    case codetype
    when 'code_128'
      generate_barcode128(value)
    when 'pdf_417'
      generate_pdf417(value)
    else
      'Format is not supported yet'
    end
  end

  def self.generate_barcode128(value)
    require 'barby'
    require 'barby/barcode/code_128'
    require 'barby/outputter/png_outputter'

    barcode = Barby::Code128B.new(value)
    png = Barby::PngOutputter.new(barcode).to_png(xdim: 2, ydim: 1)
    IO.binwrite('tmp/barcode.png', png.to_s)
    File.open('tmp/barcode.png')
  end

  def self.generate_pdf417(value)
    require 'pdf-417'
    PDF417.to_png('tmp/barcode.png', value, { x_scale: 4, y_scale: 2 })
    File.open('tmp/barcode.png')
  end
end
