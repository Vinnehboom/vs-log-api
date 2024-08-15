require 'spec_helper'

module DataImport

  RSpec.describe ActiveListDto do
    it_behaves_like 'DtoInterface', described_class
  end

end
