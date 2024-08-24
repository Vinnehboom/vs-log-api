class ListSerializer < ActiveModel::Serializer

  attributes :id, :deck_id, :name, :active, :created_at, :updated_at

  has_many :cards, if: -> { @instance_options[:expand]&.include?(:cards) }

end
