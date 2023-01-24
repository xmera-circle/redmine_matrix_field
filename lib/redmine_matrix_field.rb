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
require_relative 'redmine/field_format/combi_matrix_format'

# Overrides
require_relative 'redmine_matrix_field/overrides/custom_field_enumerations_controller_patch'
require_relative 'redmine_matrix_field/overrides/custom_fields_helper_patch'

module ComputableCustomField
  ##
  # Add combi matrix format to computable custom fields and support
  # mapping as formula.
  #
  module Configuration
    self.formats += %w[combi_matrix]
    self.formulas += %w[mapping]
  end
end

##
# Setup procedure for Redmine Matrix Field plugin
#
module RedmineMatrixField
  class << self
    def setup
      %w[custom_field_enumerations_controller_patch
         custom_fields_helper_patch].each do |patch|
        AdvancedPluginHelper::Patch.register(send(patch))
      end
      AdvancedPluginHelper::Patch.apply do
        { klass: RedmineMatrixField,
          method: :add_supported_formulas }
      end
    end

    private

    def custom_field_enumerations_controller_patch
      { klass: CustomFieldEnumerationsController,
        patch: RedmineMatrixField::Overrides::CustomFieldEnumerationsControllerPatch,
        strategy: :prepend }
    end

    def custom_fields_helper_patch
      { klass: CustomFieldsHelper,
        patch: RedmineMatrixField::CustomFieldsHelperPatch,
        strategy: :prepend }
    end

    def add_supported_formulas
      supported = ComputableCustomField::Configuration::Support.new(
        format: 'combi_matrix',
        formulas: %w[mapping]
      )
      base = supported.klass
      base.supported_math_functions = supported.formulas
    end
  end
end
