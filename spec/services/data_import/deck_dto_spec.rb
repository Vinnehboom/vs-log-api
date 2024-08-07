require 'spec_helper'

module DataImport

  RSpec.describe DeckDto do
    it_behaves_like 'DtoInterface', described_class
  end

end
