# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   program.white_label_skin
      #
      #   # bad
      #   program&.white_label_skin
      #
      #   # good
      #   Styling::AppService.new(program: current_program).display_university_styles?

      #   # good
      #   Styling::EmailService.new(program: @program).display_university_styles?

      class DirectWhiteLabelAccess < Cop
        MSG = 'Don\'t use white_label_skin directly. Instead, use the styling service Object.'

        def_node_matcher :white_label_skin?, <<~PATTERN
          ({csend send} (...) :white_label_skin)
        PATTERN

        def on_send(node)
          return unless white_label_skin?(node)

          add_offense(node)
        end

        alias on_csend on_send
      end
    end
  end
end
