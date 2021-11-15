require_relative './file_io'
require_relative './photograph'
require_relative './artist'
class Curator
  include FileIO

  attr_accessor :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(new_photo)
    @photographs.push(new_photo)
  end

  def add_artist(new_artist)
    @artists.push(new_artist)
  end

  def find_artist_by_id(id_num)
    @artists.find { |artist| artist.id == id_num }
  end

  def photographs_by_artist
    @artists.each_with_object({}) do |artist, hash|
      hash[artist] = @photographs.select { |photo| photo.artist_id == artist.id }
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      photographs_by_artist[artist].size > 1
    end
  end

  def artists_from_country(sel_country)
    @artists.find_all { |artist| artist.country == sel_country }
  end

  def photographs_taken_by_artist_from(sel_country)
    artists_from_country(sel_country).map do |artist|
      photographs_by_artist[artist]
    end.flatten
  end

  def load_photographs(photo_path)
    photo_csv_data = read_csv_data(photo_path)
    photo_csv_data.each do |photo|
      @photographs.push(Photograph.new(photo)) 
    end
  end
  
  def load_artists(artists_path)
    artists_csv_data = read_csv_data(artists_path)
    artists_csv_data.each do |artist|
      @artists.push(Artist.new(artist)) 
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all { |photo| range.include?(photo.year.to_i) }
  end

  def artists_photographs_by_age(artist)
    photo_list = photographs_by_artist[artist]

    photo_list.inject({}) do |hash, photo|
      hash[(photo.year.to_i - artist.born.to_i)] = photo.name
      hash
    end
  end
end