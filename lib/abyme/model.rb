module Abyme
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def abyme_for(association, options = {reject_if: :all_blank, allow_destroy: true})
        accepts_nested_attributes_for association, options
      end
    end
  end
end