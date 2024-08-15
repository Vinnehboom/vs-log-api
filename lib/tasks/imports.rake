namespace :data_import do
  desc 'import Decks from a given file'

  task :archetypes, %i[file game_id] => [:environment] do |_task, args|
    game = find_game(args[:game_id])
    importer = DataImport::Importer.new(dto_class: DataImport::ArchetypeDto, parser: DataImport::ArchetypeParser.new,
                                        game:)
    importer.import(data: read_file(args[:file]))
  end

  task :decks, %i[file game_id] => [:environment] do |_task, args|
    game = find_game(args[:game_id])
    importer = DataImport::Importer.new(dto_class: DataImport::DeckDto, parser: DataImport::Parser.new, game:)
    importer.import(data: read_file(args[:file]))
  end

  task :lists, %i[file game_id] => [:environment] do |_task, args|
    game = find_game(args[:game_id])
    importer = DataImport::Importer.new(dto_class: DataImport::ListDto, parser: DataImport::Parser.new, game:)
    importer.import(data: read_file(args[:file]))
  end

  task :matches, %i[file game_id] => [:environment] do |_task, args|
    game = find_game(args[:game_id])
    importer = DataImport::Importer.new(dto_class: DataImport::MatchDto, parser: DataImport::Parser.new, game:)
    importer.import(data: read_file(args[:file]))
  end

  task :match_games, %i[file game_id] => [:environment] do |_task, args|
    game = find_game(args[:game_id])
    importer = DataImport::Importer.new(dto_class: DataImport::MatchGameDto, parser: DataImport::Parser.new, game:)
    importer.import(data: read_file(args[:file]))
  end

  def read_file(file_path)
    JSON.parse(File.read(file_path))
  end

  def find_game(game_id)
    Game.find(game_id)
  end
end
