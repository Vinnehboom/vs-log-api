module Lists

  RSpec.shared_examples 'ListParserInterface' do |klass|
    subject { klass.new }

    it { is_expected.to respond_to(:parse) }
  end

end
