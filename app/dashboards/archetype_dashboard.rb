require 'administrate/base_dashboard'

class ArchetypeDashboard < Administrate::BaseDashboard

  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    cards: Field::String.with_options(searchable: false),
    decks: Field::HasMany,
    game: Field::BelongsTo,
    generation: Field::Number,
    icons: Field::ActiveStorage,
    identifier: Field::String,
    name: Field::String,
    priority: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    game
    name
    cards
    decks
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    game
    name
    cards
    decks
    generation
    icons
    identifier
    priority
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    cards
    decks
    game
    generation
    icons
    identifier
    name
    priority
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  def permitted_attributes(_action = nil)
    super + [icons: []]
  end

  # Overwrite this method to customize how archetypes are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(archetype)
    archetype.name
  end

end
