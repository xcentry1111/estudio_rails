# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   class BadPolicy
      #     def something_else
      #     end
      #   end
      #
      #   # good
      #   class GoodPolicy
      #     def program_whitelabled?
      #       program&.white_label_skin?
      #     end
      #   end

      class ProgramWhitelabeledMissing < Cop
        MSG = 'program_whitelabeled? method is missing within a Policy'

        def_node_matcher :program_whitelabeled?, <<~PATTERN
          (def :program_whitelabeled? ...)
        PATTERN

        def_node_matcher :begin_with_program_whitelabeled?, <<~PATTERN
          (begin <(def :program_whitelabeled? ...) ...>)
        PATTERN

        def_node_matcher :begin_with_def_nodes?, <<~PATTERN
          (begin <def ...>)
        PATTERN

        def on_class(node)
          return unless node.body
          return unless policy_class?(node)
          return unless at_least_one_def?(node)
          return if class_has_program_whitelabeled?(node)

          add_offense(node)
        end

        private

        def at_least_one_def?(node)
          return true if node.body.def_type?
          return begin_with_def_nodes?(node.body) if node.body.begin_type?

          false
        end

        def class_has_program_whitelabeled?(node)
          return program_whitelabeled?(node.body) if node.body.def_type?
          return begin_with_program_whitelabeled?(node.body) if node.body.begin_type?

          false
        end

        def policy_class?(node)
          /Policy$/.match?(node.loc.name.source)
        end
      end
    end
  end
end
