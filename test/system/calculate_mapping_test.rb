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
  class CalculateMappingTest < ApplicationSystemTestCase
    fixtures RedmineMatrixField::FixturesHelper.fixtures
    include RedmineMatrixField::MethodsHelper

    def setup
      super
      Capybara.current_session.reset!
      log_user 'admin', 'admin'
    end

    test 'should map to the proper result' do
      x = field_with_enumeration_format(formula: nil)
      y = field_with_enumeration_format(formula: nil)
      base = field_with_combi_matrix_format(formula: "mapping(cfs[#{x.id}], cfs[#{y.id}])")

      base_enumerations.each do |key, values|
        base.enumerations.build(values.merge(position: key.to_s))
      end
      base.save!

      x_entries = x.enumerations.map(&:id)
      x_value = CustomValue.create!(custom_field: x,
                                    value: x_entries[0],
                                    customized: issue,
                                    customized_type: Issue)
      x_value.save!
      y_entries = y.enumerations.map(&:id)
      y_value = CustomValue.create!(custom_field: y,
                                    value: y_entries[0],
                                    customized: issue,
                                    customized_type: Issue)
      y_value.save!
      visit edit_issue_path issue
      find('input[name=commit]').click
      visit issue_path issue
      assert page.has_content?('result11')
    end

    private

    def base_enumerations
      {
        '1': { name: 'result11', x_index: 1, y_index: 1 },
        '2': { name: 'result12', x_index: 1, y_index: 2 },
        '3': { name: 'result13', x_index: 1, y_index: 3 }
      }
    end
  end
end
