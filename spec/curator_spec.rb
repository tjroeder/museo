require_relative '../lib/photograph'
require_relative '../lib/artist'
require_relative '../lib/curator'

RSpec.describe Curator do 
  let(:photo1) { Photograph.new({
                                id: '1',
                                name: 'Rue Mouffetard, Paris (Boy with Bottles)',
                                artist_id: '1',
                                year: '1954'
                                }) }
  let(:photo2) { Photograph.new({
                                id: '2',
                                name: 'Moonrise, Hernandez',
                                artist_id: '2',
                                year: '1941'
                                }) }
  let(:photo3) { Photograph.new({
                                id: '3',
                                name: 'Identical Twins, Roselle, New Jersey',
                                artist_id: '3',
                                year: '1967'
                                }) }
  let(:photo4) { Photograph.new({
                                id: '4',
                                name: 'Monolith, The Face of Half Dome',
                                artist_id: '3',
                                year: '1927'
                                }) }

  let(:artist1) { Artist.new({
                              id: '1',
                              name: 'Henri Cartier-Bresson',
                              born: '1908',
                              died: '2004',
                              country: 'France'
                             }) }
  let(:artist2) { Artist.new({
                              id: '2',
                              name: 'Ansel Adams',
                              born: '1902',
                              died: '1984',
                              country: 'United States'
                             }) }
  let(:artist3) { Artist.new({
                              id: '3',
                              name: 'Diane Arbus',
                              born: '1923',
                              died: '1971',
                              country: 'United States'
                             }) }
                                
  let(:curator) { Curator.new }

  describe '#iterations 1-2' do
    describe '#initialize' do
      it 'exists' do
        expect(curator).to be_a(Curator)
      end

      it 'has attributes' do
        expect(curator.photographs).to eq([])
        expect(curator.artists).to eq([])
      end
    end

    describe '#add_photograph' do
      it 'can add photograph to photographs array' do
        curator.add_photograph(photo1)
        curator.add_photograph(photo2)

        expect(curator.photographs).to eq([photo1, photo2])
      end
    end

    describe '#add_artist' do
      it 'can add artist to artists array' do
        curator.add_artist(artist1)
        curator.add_artist(artist2)
        
        expect(curator.artists).to eq([artist1, artist2])
      end
    end
    
    describe '#find_artist_by_id' do
      it 'can find the artist by their id number' do
        curator.add_artist(artist1)
        curator.add_artist(artist2)

        expect(curator.find_artist_by_id('1')).to eq(artist1)
      end
    end
  end

  describe '#iteration 3' do
    let!(:add_artist_photos) {
      curator.add_artist(artist1)
      curator.add_artist(artist2)
      curator.add_artist(artist3)

      curator.add_photograph(photo1)
      curator.add_photograph(photo2)
      curator.add_photograph(photo3)
      curator.add_photograph(photo4)
    }

    describe '#photographs_by_artist' do
      it 'returns a hash' do
        expect(curator.photographs_by_artist).to be_a(Hash)
      end

      it 'can return photographs by each artist' do
        expected = {
                    artist1 => [photo1],
                    artist2 => [photo2],
                    artist3 => [photo3, photo4]
                   }
        expect(curator.photographs_by_artist).to eq(expected)
      end
    end

    describe '#artists_with_multiple_photographs' do
      it 'returns an array' do
        expect(curator.artists_with_multiple_photographs).to be_a(Array)
      end

      it 'returns an array of artists which have multiple photographs' do
        expect(curator.artists_with_multiple_photographs).to eq([artist3])
      end
    end

    describe '#artists_from_country' do
      it 'returns array of all artists from selected country' do
        expected = [artist2, artist3]
        expect(curator.artists_from_country('United States')).to eq(expected)
      end
    end

    describe '#photographs_taken_by_artist_from' do
      it 'returns an array' do
        expect(curator.photographs_taken_by_artist_from('United States')).to be_a(Array)
      end

      it 'returns blank array if artist country is not on list' do
        expect(curator.photographs_taken_by_artist_from('Argentina')).to eq([])
      end

      it 'returns array of photographs taken from artists country' do
        expected = [photo2, photo3, photo4]
        expect(curator.photographs_taken_by_artist_from('United States')).to eq(expected)
      end
    end
  end

  describe 'iteration4' do
    let(:artists_csv) { './data/artists.csv' }
    let(:photographs_csv) { './data/photographs.csv' }

    let(:photo_1) { Photograph.new({
                                   id: '1',
                                   name: 'Rue Mouffetard, Paris (Boy with Bottles)',
                                   artist_id: '1',
                                   year: '1954'
                                  }) }
    let(:photo_2) { Photograph.new({
                                   id: '2',
                                   name: 'Moonrise, Hernandez',
                                   artist_id: '2',
                                   year: '1941'
                                  }) }
    let(:photo_3) { Photograph.new({
                                   id: '3',
                                   name: 'Identical Twins, Roselle, New Jersey',
                                   artist_id: '3',
                                   year: '1967'
                                  }) }
    let(:photo_4) { Photograph.new({
                                   id: '4',
                                   name: 'Child with Toy Hand Grenade in Central Park',
                                   artist_id: '3',
                                   year: '1962'
                                  }) }

    describe '#read_csv_data' do
      it 'can read in CSV object' do
        expect(curator.read_csv_data(photographs_csv)).to be_a_kind_of(CSV::Table)
        expect(curator.read_csv_data(artists_csv)).to be_a_kind_of(CSV::Table)
      end
    end

    describe '#load_photographs' do
      it 'can load CSV to create Photograph objects' do
        curator.load_photographs(photographs_csv)
        
        expect(curator.photographs[0]).to be_a(Photograph)
        expect(curator.photographs[1]).to be_a(Photograph)
        expect(curator.photographs[2]).to be_a(Photograph)
        expect(curator.photographs[3]).to be_a(Photograph)
      end
      
      it 'can load CSVs to create Photograph attributes' do
        curator.load_photographs(photographs_csv)
        
        expected = { 
          id: '1', 
          name: 'Rue Mouffetard, Paris (Boy with Bottles)',
          artist_id: '1',
          year: '1954'
        }
        expect(curator.photographs[0]).to have_attributes(expected)
      end
    end
    
    describe '#load_artists' do
      it 'can load CSV to artist attribute' do
        curator.load_artists(artists_csv)
        
        expect(curator.artists[0]).to be_a(Artist)
        expect(curator.artists[1]).to be_a(Artist)
        expect(curator.artists[2]).to be_a(Artist)
        expect(curator.artists[3]).to be_a(Artist)
      end
      
      it 'can load CSV to artist attribute' do
        curator.load_artists(artists_csv)
        
        expected = {
          id: '1',
          name: 'Henri Cartier-Bresson',
          born: '1908',
          died: '2004',
          country: 'France'
        }
        expect(curator.artists[0]).to have_attributes(expected)
      end
    end
    
    describe '#photographs_taken_between' do
      it 'can return photographs when given a range' do
        curator.load_photographs(photographs_csv)
        photographs = curator.photographs
        expected = [photographs[0], photographs[3]]

        expect(curator.photographs_taken_between(1950..1965)).to eq(expected)
      end
    end

    describe '#artists_photographs_by_age' do
      it 'returns the artists photos by the age the artist was when captured' do
        curator.load_artists(artists_csv)
        curator.load_photographs(photographs_csv)
        diane_arbus = curator.find_artist_by_id('3')
        
        expected = {
                    44 => 'Identical Twins, Roselle, New Jersey',
                    39 => 'Child with Toy Hand Grenade in Central Park'
                   }
        expect(curator.artists_photographs_by_age(diane_arbus)).to eq(expected)
      end
    end
  end
end