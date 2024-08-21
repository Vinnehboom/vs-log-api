require 'spec_helper'

module Lists

  RSpec.describe PokemonTcgParser do
    it_behaves_like 'ListParserInterface', described_class
  end

end
