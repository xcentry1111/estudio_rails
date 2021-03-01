# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   class Program < ApplicationRecord
      #     # ...
      #   end
      #
      #   # good
      #   class Program < ApplicationRecord
      #     acts_as_multi_tenant
      #
      #     # ...
      #   end

      class ActsAsMultiTenant < Cop
        MSG = <<~MSG.chomp
          If the model is related to only one university, you probably need to add `acts_as_multi_tenant` to it. Otherwise, exclude the file.
        MSG

        def_node_matcher :abstract_class?, <<-PATTERN
          `(send (self) :abstract_class= (true))
        PATTERN

        def_node_matcher :acts_as_multi_tenant?, <<-PATTERN
          `(send nil? :acts_as_multi_tenant)
        PATTERN

        def_node_matcher :model?, <<-PATTERN
          (const ... :ApplicationRecord)
        PATTERN

        def on_class(node)
          return unless model?(node.parent_class)
          return if abstract_class?(node)
          return if acts_as_multi_tenant?(node)

          add_offense(node)
        end
      end
    end
  end
end
