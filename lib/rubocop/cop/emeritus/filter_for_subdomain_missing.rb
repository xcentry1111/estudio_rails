# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   class BadPolicy
      #     class Scope
      #     end
      #   end
      #
      #   # good
      #   class GoodPolicy
      #     class Scope
      #       def filter_for_subdomain(_scope)
      #         _scope
      #       end
      #     end
      #   end

      class FilterForSubdomainMissing < Cop
        MSG = 'filter_for_subdomain method is missing within the Scope of a Policy'

        def_node_matcher :scope_class?, <<~PATTERN
          (class (const _ :Scope) ...)
        PATTERN

        # There's a begin node if the class has more than one child, the ` symbol goes through the descendants
        # The <node ...> expression matches the node, no matter the order or the number of siblings
        def_node_matcher :filter_for_subdomain_method?, <<~PATTERN
          (class <`(def :filter_for_subdomain ...) ...>)
        PATTERN

        def on_class(node)
          return unless scope_class?(node)
          return unless parent_policy_class?(node)
          return if filter_for_subdomain_method?(node)

          add_offense(node)
        end

        private

        def policy_class?(node)
          /Policy$/.match?(node.loc.name.source)
        end

        def parent_policy_class?(node)
          # The begin node wraps the class body if it has more than one child
          # In case a class def is the only child inside a class body, the begin node does not exist
          return policy_class?(node.parent.parent) if node&.parent&.begin_type?
          return policy_class?(node.parent) if node&.parent&.class_type?

          false
        end
      end
    end
  end
end
