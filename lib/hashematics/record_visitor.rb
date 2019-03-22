# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # A RecordVisitor is a Record found in the context of a Group.  When traversing the object
  # graph (group tree), it will provider these RecordVisitor objects instead of Record objects
  # that allows you to view the Record in the context of the graph, while a Record is more of just
  # the raw payload provided by the initial flat data set.
  class RecordVisitor
    attr_reader :record, :group

    def initialize(record, group)
      @record = record.is_a?(self.class) ? record.record : record
      @group  = group

      freeze
    end

    def object
      child_hash = child_group_names.map do |group_name|
        [
          group_name,
          group.objects(group_name: group_name, parent_record: record)
        ]
      end.to_h

      group.type.convert(record, child_hash)
    end

    def child_group_names
      group.child_group_names
    end

    def child_records(group_name)
      group.records(group_name: group_name, parent_record: record)
    end
  end
end
