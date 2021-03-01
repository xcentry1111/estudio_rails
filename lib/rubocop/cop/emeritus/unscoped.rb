# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   Payment.unscoped
      #   # good
      #   # work with scopes. check default scopes if necessary
      #   Payment.scope

      class Unscoped < Cop
        MSG = 'Don\'t use unscoped. Its use is discouraged as it might break multitenancy.'

        def_node_matcher :unscoped?, <<~PATTERN
          ({csend send} (...) :unscoped)
        PATTERN

        def on_send(node)
          return unless unscoped?(node)

          add_offense(node)
        end

        alias on_csend on_send
      end
    end
  end
end
