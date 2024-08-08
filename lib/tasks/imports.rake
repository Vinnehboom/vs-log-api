namespace :data_import do
  desc 'import Decks from a given file'
  task :decks, [:file] => [:environment] do |_task, args|
    importer = DataImport::Importer.new(dto_class: DataImport::DeckDto, parser: DataImport::Parser.new)
    importer.import(data: read_file(args[:file]))
  end

  task :lists, [:file] => [:environment] do |_task, args|
    importer = DataImport::Importer.new(dto_class: DataImport::ListDto, parser: DataImport::Parser.new)
    importer.import(data: read_file(args[:file]))
  end

  def read_file(file_path)
    JSON.parse(File.read(file_path))
  end
end
