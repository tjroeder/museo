require_relative '../lib/photograph'

RSpec.describe Photograph do 
  let(:photo1) { {
                  id: '1',
                  name: 'Rue Mouffetard, Paris (Boy with Bottles)',
                  artist_id: '4',
                  year: '1954'
                 } }
  let(:rue_mouffetard) { Photograph.new(photo1) }

  describe '#initialize' do
    it 'exists' do
      expect(rue_mouffetard).to be_a(Photograph)
    end

    it 'has attributes' do
      expect(rue_mouffetard.id).to eq('1')
      expect(rue_mouffetard.name).to eq('Rue Mouffetard, Paris (Boy with Bottles)')
      expect(rue_mouffetard.artist_id).to eq('4')
      expect(rue_mouffetard.year).to eq('1954')
    end
  end
end