class ArchetypeSerializer < ActiveModel::Serializer

  attributes :id, :name, :identifier, :generation, :game_id, :cards, :icons

  def icons
    object.icons.map { |icon| { icon.filename => url(icon:) } }
  end

  def url(icon:)
    "#{icon.service.bucket.url}/#{icon.blob.key}"
  end

end
