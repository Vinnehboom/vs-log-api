module Cards

  RSpec.describe Image do
    describe '#url' do
      it 'raises an exception' do
        expect { described_class.new(card: nil).url }.to raise_exception('#url not implemented')
      end
    end
  end

end
