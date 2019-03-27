# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Hashematics
  # A Category is an index of objects.  It holds two things:
  # 1. list of top-level objects
  # 2. list of top-level objects cross-referenced by a parent.
  class Category
    attr_reader :id_key, :parent_key

    def initialize(parent_key: nil, id_key: nil)
      @parent_key         = Key.get(parent_key)
      @id_key             = Key.get(id_key)
      @lookup             = {}
      @default_parent_id  = Id.default

      freeze
    end

    def records(parent_record = nil)
      parent_id = parent_record&.id(parent_key) || default_parent_id

      get(parent_id).values
    end

    def add(record)
      set(
        record.id(parent_key),
        record.id(id_key),
        record
      )
    end

    private

    attr_reader :default_parent_id, :lookup

    def get(parent_id)
      lookup[parent_id] ||= {}
    end

    def set(parent_id, id, record)
      get(parent_id)[id] = record

      self
    end
  end
end
