# frozen_string_literal: true

# This file is part of the Plugin Redmine Combination Matrix Field.
#
# Copyright (C) 2021 Liane Hampe <liaham@xmera.de>, xmera.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

require File.expand_path('../test_helper', __dir__)

module RedmineMatrixField
  class CustomFieldMatrixTest < RedmineMatrixFieldUnitTestCase
    test 'should complain missing fields' do
      field = field_with_combi_matrix_format(formula: nil)
      matrix = CustomFieldMatrix.new(field, nil, nil)
      assert matrix.send :no_fields?
    end

    test 'should complain missing formula' do
      field = field_with_combi_matrix_format(formula: nil)
      matrix = CustomFieldMatrix.new(field, nil, nil)
      assert matrix.send :no_formula?
    end

    test 'should complain no matrix' do
      field = field_with_enumeration_format(formula: nil)
      matrix = CustomFieldMatrix.new(field, nil, nil)
      assert matrix.send :no_matrix?
    end

    test 'should complain having no entries' do
      field = field_with_combi_matrix_format(formula: nil)
      matrix = CustomFieldMatrix.new(field, nil, nil)
      assert_not matrix.send :entries?
    end

    test 'should determine matrix dimensions' do
      x = field_with_enumeration_format(formula: nil)
      y = field_with_enumeration_format(formula: nil)
      base = field_with_combi_matrix_format(formula: "mapping(cfs[#{x.id}], cfs[#{y.id}])")
      matrix = CustomFieldMatrix.new(base, x, y)
      assert_equal [(1..9).to_a, (1..9).to_a], matrix.send(:dimensions)
    end

    test 'should determine field combinations' do
      x = field_with_enumeration_format(formula: nil)
      y = field_with_enumeration_format(formula: nil)
      base = field_with_combi_matrix_format(formula: "mapping(cfs[#{x.id}], cfs[#{y.id}])")
      matrix = CustomFieldMatrix.new(base, x, y)
      combination = [[1, 1],[1, 2],[1, 3],[1, 4],[1, 5],[1, 6],[1, 7],[1, 8],[1, 9],
                     [2, 1],[2, 2],[2, 3],[2, 4],[2, 5],[2, 6],[2, 7],[2, 8],[2, 9], 
                     [3, 1],[3, 2],[3, 3],[3, 4],[3, 5],[3, 6],[3, 7],[3, 8],[3, 9],
                     [4, 1],[4, 2],[4, 3],[4, 4],[4, 5],[4, 6],[4, 7],[4, 8],[4, 9],
                     [5, 1],[5, 2],[5, 3],[5, 4],[5, 5],[5, 6],[5, 7],[5, 8],[5, 9], 
                     [6, 1],[6, 2],[6, 3],[6, 4],[6, 5],[6, 6],[6, 7],[6, 8],[6, 9],
                     [7, 1],[7, 2],[7, 3],[7, 4],[7, 5],[7, 6],[7, 7],[7, 8],[7, 9],
                     [8, 1],[8, 2],[8, 3],[8, 4],[8, 5],[8, 6],[8, 7],[8, 8],[8, 9],
                     [9, 1],[9, 2],[9, 3],[9, 4],[9, 5],[9, 6],[9, 7],[9, 8],[9, 9]]
                     
      assert_equal combination, matrix.send(:combinations)
    end
  end
end
