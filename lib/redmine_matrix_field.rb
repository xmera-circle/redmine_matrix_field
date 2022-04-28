# frozen_string_literal: true

# This file is part of the Plugin Redmine Combination Matrix Field.
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
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

# Extensions
require 'redmine/field_format/combi_matrix_format'

# Overrides
require 'redmine_matrix_field/overrides/custom_field_enumerations_controller_patch'
require 'redmine_matrix_field/overrides/custom_fields_helper_patch'

module ComputableCustomField
  module Configuration
    self.formats += %w[combi_matrix]
    self.formulas += %w[mapping]
  end
end

Rails.configuration.to_prepare do
  supported = ComputableCustomField::Configuration::Support.new(
    format: 'combi_matrix',
    formulas: %w[mapping]
  )
  base = supported.klass
  base.supported_math_functions = supported.formulas
end
