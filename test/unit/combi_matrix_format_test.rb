# frozen_string_literal: true

# This file is part of the Plugin Redmine Combination Matrix Field.
#
# Copyright (C) 2022 Liane Hampe <liaham@xmera.de>, xmera.
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
  class CombiMatrixFormatTest < RedmineMatrixFieldUnitTestCase
    # Custom Field formats:
    #  - id: 6 -> float field
    #  - id: 8 -> date field

    def setup
      @field = field_with_enumeration_format(formula: nil)
      @combi_matrix = Redmine::FieldFormat::CombiMatrixFormat.instance
    end

    test 'should use position in possible_value_options' do
      current_values = @combi_matrix.possible_values_options(@field)
      expected_values = [["result1", "1"], ["result2", "2"], ["result3", "3"], ["result4", "4"], ["result5", "5"], ["result6", "6"], ["result7", "7"], ["result8", "8"], ["result9", "9"]]
      assert_equal expected_values, current_values
      current_positions = @field.enumerations.map(&:position)
      expected_positions = expected_values.map(&:last).map(&:to_i)
      assert_equal expected_positions, current_positions
    end

    test 'should use value in order statement' do
      current = @combi_matrix.order_statement(@field)
      expected =  ["cf_#{@field.id}.value"]
      assert_equal expected, current
    end
  end
end