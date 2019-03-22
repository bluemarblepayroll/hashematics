# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # A RecordSet creates Records and maintains a master list of Records.
  class RecordSet
    attr_reader :records

    def initialize
      @records = []

      freeze
    end

    def add(hash)
      record = Record.new(hash)

      records << record

      record
    end

    def objects
      records.map(&:data)
    end
  end
end
