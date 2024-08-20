module Cards

  RSpec.shared_examples 'CardImageInterface' do |klass|
    subject { klass.new(card: {}) }

    it { is_expected.to respond_to(:url) }
  end

end
