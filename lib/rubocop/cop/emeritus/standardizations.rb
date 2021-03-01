# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   t(:key)
      #
      #   # bad
      #   l(:key)
      #
      #   # bad
      #   I18n.t(:key)
      #
      #   # good
      #   E18n.et(:key)

      #   # good
      #   E18n.el(:key)

      class Standardizations < Cop
        MSG = 'Don\'t use the I18n methods directly. Instead, use the methods from the E18n class.'

        def_node_matcher :t?, <<~PATTERN
          (send ... :t (...))
        PATTERN

        def_node_matcher :l?, <<~PATTERN
          (send ... :l (...))
        PATTERN

        def on_send(node)
          return unless t?(node) || l?(node)

          add_offense(node)
        end

        alias on_csend on_send
      end
    end
  end
end
