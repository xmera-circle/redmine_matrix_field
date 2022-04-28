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
  class CustomFieldCombiMatrixTest < RedmineMatrixFieldControllerTestCase
    test 'should set combi matrix field to calculation by default' do
      log_user('admin', 'admin')
      get new_custom_field_path, params: { type: 'IssueCustomField',
                                           custom_field: { field_format: 'combi_matrix' } }
      assert_response :success

      assert_select '#custom_field_field_format', 1
      assert_select '#custom_field_is_computed', 1
      assert_select 'input[type=checkbox][name=?][checked=checked][value=1]', 'custom_field[is_computed]'
    end
  end
end
