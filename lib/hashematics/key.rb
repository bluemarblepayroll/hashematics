# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # A Key is a unique identifier and can be used for hash keys, comparison, etc.
  # Essentially it is a joined and hashed list of strings.
  class Key
    extend Forwardable

    class << self
      def get(parts = [])
        return parts if parts.is_a?(self)

        keys[parts] ||= new(parts)
      end
      alias default get

      private

      def keys
        @keys ||= {}
      end
    end

    SEPARATOR = '::'

    private_constant :SEPARATOR

    def_delegators :parts, :each_with_object, :map

    attr_reader :parts, :value

    def initialize(parts = [])
      @parts = Array(parts)
      @value = make_value

      freeze
    end

    def to_s
      value
    end

    def eql?(other)
      value == other.is_a?(self.class) ? other.value : self.class.new(other).value
    end

    def ==(other)
      eql?(other)
    end

    def hash
      value.hash
    end

    private

    def make_value
      parts.map(&:to_s).join(SEPARATOR)
    end
  end
end
