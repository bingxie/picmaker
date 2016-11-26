module Concerns
  module Query
    extend ActiveSupport::Concern

    included do
      attr_reader :relation

      class << self
        delegate :call, to: :new
      end
    end

    def initialize(relation)
      @relation = relation
    end

    def call
      relation
    end
  end
end
