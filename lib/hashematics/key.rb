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
    class << self
      def make(arg)
        arg.is_a?(self) ? arg : new(arg)
      end
    end

    SEPARATOR = '::'

    private_constant :SEPARATOR

    attr_reader :parts, :value

    def initialize(parts = [])
      @parts = Array(parts)
      @value = @parts.map(&:to_s).join(SEPARATOR)

      freeze
    end

    def map(&block)
      parts.map(&block)
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
      to_s.hash
    end
  end
end
