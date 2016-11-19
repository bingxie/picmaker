module PictureAASM
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm do
      state :draft, initial: true
      state :approved

      event :approve do
        transitions from: :draft, to: :approved
      end
    end
  end
end
