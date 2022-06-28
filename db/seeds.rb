# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
codes = Codetype.create!([
                           { name: 'Code 25', alias: 'code_25' },
                           { name: 'Code 25 Interleaved', alias: 'code_25_interleaved' },
                           { name: 'Code 25  IATA', alias: 'code_25_iata' },
                           { name: 'Code 39', alias: 'code_39' },
                           { name: 'Code 93', alias: 'code_93' },
                           { name: 'Code 128 (A, B, and C)', alias: 'code_128' },
                           { name: 'GS1 128', alias: 'gs1_128' },
                           { name: 'EAN-13 UPC-A', alias: 'ean_13' },
                           { name: 'EAN-8', alias: 'ean_8' },
                           { name: 'UPC/EAN supplemental, 2 & 5 digits', alias: 'upc_supplemental' },
                           { name: 'QR Code', alias: 'qr_code' },
                           { name: 'DataMatrix (Semacode)', alias: 'data_matrix' },
                           { name: 'PDF417', alias: 'pdf_417' }
                         ])

vendors = Vendor.create!([
                           { name: 'лента', alias: 'lenta', codetype_id: 13 },
                           { name: 'дикси', alias: 'dixy', codetype_id: 6 },
                           { name: 'спортлайф', alias: 'sl', codetype_id: 6 }
                         ])
