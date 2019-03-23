# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Hashematics::Mapper do
  let(:csv_rows) { csv_fixture('data.csv') }

  let(:configuration) { yaml_fixture('config.yml') }

  let(:people) { yaml_fixture('people.yml') }

  let(:groups) { ::Hashematics::Configuration.new(configuration).groups }

  describe '#children' do
    it 'returns list of child group names' do
      mapper = ::Hashematics::Mapper.new(groups).add(csv_rows)

      actual_children = mapper.children

      expected_children = groups.map(&:name)

      expect(actual_children).to eq(expected_children)
    end
  end

  describe '#data' do
    context 'with no object_class specifications' do
      it 'should parse configuration and return object graph' do
        mapper = ::Hashematics::Mapper.new(groups).add(csv_rows)

        actual_people = mapper.data('people')

        # binding.pry

        expect(actual_people).to eq(people)
      end
    end

    context 'with object_class open_struct specifications' do
      let(:modified_configuration) do
        yaml_fixture('config.yml').tap do |c|
          c.dig('types', 'person')['object_class'] = 'open_struct'
        end
      end

      let(:modified_groups) do
        ::Hashematics::Configuration.new(modified_configuration).groups
      end

      let(:modified_people) do
        yaml_fixture('people.yml').map { |h| OpenStruct.new(h) }
      end

      it 'should parse configuration and return object graph' do
        mapper = ::Hashematics::Mapper.new(modified_groups).add(csv_rows)

        actual_people = mapper.data(:people)

        expect(actual_people).to eq(modified_people)
      end
    end
  end
end
