require 'spec_helper'

module DataImport

  RSpec.describe Importer do
    let(:parser_double) { instance_double(Parser) }
    let(:dto_class_double) { class_double(DeckDto) }
    let(:game) { create(:game) }
    let(:dto_double) { instance_double(DeckDto) }
    let(:importer) { described_class.new(parser: parser_double, dto_class: dto_class_double, game:) }

    before do
      allow(dto_class_double).to receive(:new).and_return(dto_double)
      allow(dto_double).to receive(:update_instance)
      allow(parser_double).to receive(:parse).and_return([{}])
    end

    describe '#import' do
      it 'parses the given data' do
        importer.import(data: [{}])
        expect(parser_double).to have_received(:parse)
      end

      it 'updates the database with the parsed data' do
        importer.import(data: [])
        expect(dto_class_double).to have_received(:new)
        expect(dto_double).to have_received(:update_instance)
      end
    end
  end

end
