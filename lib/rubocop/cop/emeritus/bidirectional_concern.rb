# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Emeritus
      #   # bad
      #   module Concern
      #     extend ActiveSupport::Concern
      #
      #     def method
      #      do_something(object)
      #     end
      #    end
      #
      #
      #   # good
      #   module CustomConcern
      #     extend ActiveSupport::Concern
      #
      #     def method(object)
      #      do_something(object)
      #     end
      #    end
      #
      #   # good
      #   module CustomConcern
      #     extend ActiveSupport::Concern
      #
      #     def custom_method
      #      do_something(another_method)
      #     end
      #
      #     def another_method
      #       constant
      #     end
      #    end

      class BidirectionalConcern < Cop
        require_relative '../../../../config/environment'
        MSG = 'Don\'t use the objects directly on the concern. ' \
              'Instead, pass them as parameters on the method.'

        def_node_search :def_methods, '(def $_method_name ...)'

        def_node_search :possible_dependencies, '(send nil? $_name ...)'

        def investigate(processed_source)
          return if processed_source.blank?
          return unless concern_class?(processed_source)

          tree = processed_source.ast
          possible_dependencies(tree).uniq.excluding(keywords).each do |name|
            next if defined_keywords? name

            search_def_methods(tree, name)
          end
        end

        private

        def concern_class?(processed_source)
          /^\s{1,}[^#]\s{1,}extend ActiveSupport::Concern$/.match?(processed_source.raw_source)
        end

        def search_def_methods(tree, name)
          methods = def_methods(tree)
          methods.each_with_index do |method_name, index|
            break if name == method_name
            next unless index + 1 == methods.count

            add_offense(tree)
          end
        end

        def defined_keywords?(name)
          String.method_defined?(name) || ::ActionController::Base.methods.include?(name) ||
            ::ActionController::Base.instance_methods.include?(name) ||
            ::Rails.application.routes.url_helpers.method_defined?(name) ||
            ::Split::Helper.methods.include?(name)
        end

        def keywords
          [:protected, :private, :included, :cookies, :raise]
        end
      end
    end
  end
end
