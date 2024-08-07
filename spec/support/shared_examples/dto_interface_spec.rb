require 'spec_helper'

module DataImport

  RSpec.shared_examples 'DtoInterface' do |klass|
    subject { klass.new(object: {}) }

    it { is_expected.to respond_to(:update_instance) }
  end

end
