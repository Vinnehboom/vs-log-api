class CardSerializer < ActiveModel::Serializer

  attributes :count, :name, :set_id, :set_number

  delegate :image, to: :object

end
