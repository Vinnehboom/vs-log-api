require 'spec_helper'

module DataImport

  RSpec.shared_examples 'DtoInterface' do |klass|
    subject { klass.new(object: {}, game: create(:game)) }

    it { is_expected.to respond_to(:update_instance) }
    it { is_expected.to respond_to(:game) }
  end

end
