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
  class FormulaValidatorTest < RedmineMatrixFieldUnitTestCase
    # Custom Field formats:
    #  - id: 6 -> float field
    #  - id: 8 -> date field

    test 'should confirm valid formulas' do
      field = field_validation(formula: 'mapping(cfs[6],cfs[6])',
                               field_format: 'combi_matrix')
      assert field.valid?
    end

    test 'should complain too many fields' do
      validation = assert_raise ActiveRecord::RecordInvalid do
        field_validation(formula: 'mapping(cfs[6],cfs[6],cfs[6])',
                         field_format: 'combi_matrix')
      end
      assert_equal "Validation failed: #{l(:error_too_many_fields)}", validation.message
    end

    test 'should complain wrong delimiter' do
      validation = assert_raise ActiveRecord::RecordInvalid do
        field_validation(formula: 'mapping(cfs[6]~cfs[6])',
                         field_format: 'combi_matrix')
      end
      assert_equal "Validation failed: #{l(:error_missing_arguments)}", validation.message
    end

    private

    def field_validation(formula:, field_format:)
      public_send "field_with_#{field_format}_format", formula: formula
    end
  end
end
