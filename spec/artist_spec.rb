require_relative '../lib/artist'

RSpec.describe Artist do 
  let(:artist1) { {
                  id: '2',
                  name: 'Ansel Adams', 
                  born: '1902',
                  died: '1984',
                  country: 'United States'
                  } }
  let(:adams) { Artist.new(artist1) }

  describe '#initialize' do
    it 'exists' do
      expect(adams).to be_a(Artist)
    end

    it 'has attributes' do
      expect(adams.id).to eq('2')
      expect(adams.name).to eq('Ansel Adams')
      expect(adams.born).to eq('1902')
      expect(adams.died).to eq('1984')
      expect(adams.country).to eq('United States')
    end
  end

  describe '#age_at_death' do
    it 'returns a integer' do
      expect(adams.age_at_death).to be_a(Integer)
    end

    it 'can return the age of death' do
      expect(adams.age_at_death).to eq(82)
    end
  end
end