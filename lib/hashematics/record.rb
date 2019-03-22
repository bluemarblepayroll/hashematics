# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # A Record object is composed of an inner object (most likely a hash) and provides extra
  # methods for the library.
  class Record
    class << self
      def digest(val = '')
        Digest::MD5.hexdigest(val)
      end
    end

    SEPARATOR = '::'

    private_constant :SEPARATOR

    attr_reader :data

    def initialize(data = {})
      @data       = data
      @ids_by_key = {}

      freeze
    end

    def id(key)
      key = Key.make(key)
      @ids_by_key[key] ||= self.class.digest(make_undigested_id(key))
    end

    def keys
      data.keys
    end

    def [](key)
      ObjectInterface.get(data, key)
    end

    def eql?(other)
      data == other.is_a?(self.class) ? other.data : self.class.new(other).data
    end

    def ==(other)
      eql?(other)
    end

    def hash
      data.hash
    end

    private

    attr_reader :group_ids

    def make_undigested_id(key)
      key.map { |p| "#{p}#{SEPARATOR}#{data[p]}" }.join(SEPARATOR)
    end
  end
end
