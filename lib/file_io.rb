require 'csv'
module FileIO
  def read_csv_data(location)
    CSV.read(location, headers: true, header_converters: :symbol)
  end
end