module Abyme
  module Abymize
    extend ActiveSupport::Concern

    class_methods do
      def abyme_for(association)
        accepts_nested_attributes_for association, reject_if: :all_blank, allow_destroy: true
      end
    end
  end
end