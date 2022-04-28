# frozen_string_literal: true

# This file is part of the Plugin Redmine Colored Enumeration.
#
# Copyright (C) 2021 - 2022 Liane Hampe <liaham@xmera.de>, xmera.
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
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

Deface::Override.new(
  virtual_path: 'custom_field_enumerations/index',
  name: 'add-custom-field-combinations',
  insert_before: "erb[loud]:contains('text_field_tag')",
  partial: 'custom_field_enumerations/custom_field_combinations',
  original: '8f334d1e9c433ffc0fae1c3b5865e4b0d28b00aa',
  sequence: 20,
  namespaced: true
)

Deface::Override.new(
  virtual_path: 'custom_field_enumerations/index',
  name: 'remove-add-enumeration-form',
  surround: "erb[loud]:contains(':remote => true')",
  closing_selector: "erb[silent]:contains('end')",
  text: "<% unless @custom_field.field_format == 'combi_matrix' %><%= render_original %><% end %>",
  original: 'ed83e2e738a516a508ab7bcbaf8a8bb2b2780ce5',
  sequence: 30,
  namespaced: true
)

Deface::Override.new(
  virtual_path: 'custom_field_enumerations/index',
  name: 'replace-delete-link',
  replace: "erb[loud]:contains('delete_link custom_field_enumeration_path(@custom_field, value)')",
  text: '<%= delete_link(custom_field_enumeration_path(@custom_field, value)) if value.id %>',
  original: '0cfc01e5b9fe3860dda2b07bc8d2fe4df7ae8853',
  sequence: 40,
  namespaced: true
)

Deface::Override.new(
  virtual_path: 'custom_field_enumerations/index',
  name: 'add-custom-field-combinations-nodata',
  insert_before: "erb[loud]:contains('javascript_tag')",
  partial: 'custom_field_enumerations/custom_field_combinations_nodata',
  original: '1bba397d96310354763a84268ec9fc406f5a6788',
  sequence: 50,
  namespaced: true
)
