# frozen_string_literal: true

# This file is part of the Plugin Redmine Combination Matrix Field.
#
# Copyright (C) 2021-2023 Liane Hampe <liaham@xmera.de>, xmera Solutions GmbH.
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
  class CustomFieldEnumerationsTest < RedmineMatrixFieldControllerTestCase
    test 'should prepare matrix entries' do
      log_user('admin', 'admin')
      x = field_with_enumeration_format(formula: nil)
      y = field_with_enumeration_format(formula: nil)

      base = field_with_combi_matrix_format(formula: "mapping(cfs[#{x.id}], cfs[#{y.id}])")
      get custom_field_enumerations_path(base)

      assert_select 'span.x_index', 81
      assert_select 'span.y_index', 81
      assert_select '#custom_field_enumerations' do |elements|
        elements.each do |element|
          assert_select element, 'li', 81
        end
      end
    end

    test 'should ignore matrix preparation unless field format combi_matrix' do
      field = field_with_enumeration_format(formula: nil)
      get custom_field_enumerations_path(field)
      assert_select 'span.x_index', 0
      assert_select 'span.y_index', 0
      assert_select '#custom_field_enumerations', 0
    end
  end
end
