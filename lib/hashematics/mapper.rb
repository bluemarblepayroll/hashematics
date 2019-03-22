# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # Mapper serves as the main point of entry for this system.
  # Basic use:
  # 1. Initialize a Mapper by passing in an array of groups (tree structures)
  # 2. Feed in objects into the mapper using the #add method
  # 3. Use the #groups, #records, and #objects methods to interact with the generated object graph.
  class Mapper
    attr_reader :group_dictionary, :record_set

    def initialize(groups = [])
      @group_dictionary = Dictionary.new.add(groups, &:name)
      @record_set       = RecordSet.new

      freeze
    end

    def group(name)
      group_dictionary.get(name)
    end

    def group_names
      group_dictionary.map(&:name)
    end

    def records(group_name = nil)
      return record_set.records unless group_name

      group(group_name)&.records || []
    end

    def objects(group_name = nil)
      return record_set.objects unless group_name

      group(group_name)&.objects || []
    end

    def add(hash_or_enumerable)
      if hash_or_enumerable.is_a?(Hash)
        add_one(hash_or_enumerable)
      else
        hash_or_enumerable.each { |hash| add_one(hash) }
      end

      self
    end

    private

    def add_one(hash)
      record = record_set.add(hash)

      group_dictionary.each do |group|
        group.add(record)
      end

      self
    end
  end
end
