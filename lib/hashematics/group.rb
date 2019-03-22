# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # A group is a node in a tree structure connected to other groups through the children
  # attribute.  A group essentially represents an object within the object graph and its:
  # 1. Category (index) for the parent to use as a lookup
  # 2. Type that describes the object properties, field mapping, etc.
  class Group
    attr_reader :category, :name, :type

    def initialize(category:, children:, name:, type:)
      @category         = category
      @child_dictionary = Dictionary.new.add(children, &:name)
      @name             = name
      @type             = type

      freeze
    end

    def add(record)
      category.add(record)

      child_dictionary.each { |c| c.add(record) }

      self
    end

    def child_group_names
      child_dictionary.map(&:name)
    end

    def child_group(group_name)
      child_dictionary.get(group_name)
    end

    def records(group_name: nil, parent_record: nil)
      group = group_name ? child_group(group_name) : self

      grouped_records =
        if group_name
          child_group(group_name)&.records(parent_record: parent_record) || []
        else
          category.records(parent_record)
        end

      grouped_records.map do |grouped_record|
        RecordVisitor.new(grouped_record, group)
      end
    end

    def objects(group_name: nil, parent_record: nil)
      records(group_name: group_name, parent_record: parent_record).map(&:object)
    end

    private

    attr_reader :child_dictionary
  end
end
