# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Hashematics::Record do
  let(:csv_rows) { csv_fixture('data.csv') }

  describe '#category_id' do
    it 'memoizes computed ids' do
      record = ::Hashematics::Record.new(name: 'Matt')
      ids_by_key_var = record.instance_variable_get('@ids_by_key')

      expect(ids_by_key_var.keys).to eq([])
      record.id(:name)
      expect(ids_by_key_var.keys).to eq(['name'])

      key = ::Hashematics::Key.new('name')
      ids_by_key_var[key] = 'SOMETHING'
      expect(record.id('name')).to eq('SOMETHING')
      expect(ids_by_key_var.keys).to eq(['name'])
      expect(ids_by_key_var.values).to eq(['SOMETHING'])
    end

    it 'returns correct ID for specified keys' do
      records = csv_rows.map { |row| ::Hashematics::Record.new(row) }

      keys = [
        'ID #',
        ['ID #', 'Car ID #'],
        ['ID #', 'House ID #']
      ].map { |p| ::Hashematics::Key.new(p) }

      keys.each do |key|
        records.each do |record|
          concat_only = key.map { |p| "#{p}::#{record[p]}" }.join('::')
          expected_id = ::Hashematics::Record.digest(concat_only)

          actual_id = record.id(key)

          expect(actual_id).to eq(expected_id)
        end
      end
    end
  end
end
