class NewPicturesQuery
  include ::Concerns::Query

  def initialize(relation = Picture.approved)
    super
  end

  def call
    relation.reorder(:created_at)
  end
end
