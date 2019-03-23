# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'
require 'examples/person'

describe ::Hashematics::ObjectInterface do
  let(:input) do
    {
      id: 1,
      'first' => 'Matt'
    }
  end

  let(:person) { Person.new(input) }

  it 'should read hash indifferently' do
    expect(::Hashematics::ObjectInterface.get(input, :id)).to eq(input[:id])
    expect(::Hashematics::ObjectInterface.get(input, 'id')).to eq(input[:id])
    expect(::Hashematics::ObjectInterface.get(input, :first)).to eq(input['first'])
    expect(::Hashematics::ObjectInterface.get(input, 'first')).to eq(input['first'])

    expect(::Hashematics::ObjectInterface.get(person, 'doesnt_exist')).to eq(nil)
    expect(::Hashematics::ObjectInterface.get(person, :doesnt_exist)).to eq(nil)
  end

  it 'should read object if object is responsive' do
    expect(::Hashematics::ObjectInterface.get(person, :id)).to eq(input[:id])
    expect(::Hashematics::ObjectInterface.get(person, 'id')).to eq(input[:id])
    expect(::Hashematics::ObjectInterface.get(person, :first)).to eq(input['first'])
    expect(::Hashematics::ObjectInterface.get(person, 'first')).to eq(input['first'])

    expect(::Hashematics::ObjectInterface.get(person, 'doesnt_exist')).to eq(nil)
    expect(::Hashematics::ObjectInterface.get(person, :doesnt_exist)).to eq(nil)
  end
end
