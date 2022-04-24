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

module Redmine
  module FieldFormat
    class CombiMatrixFormat < Redmine::FieldFormat::EnumerationFormat
      include ComputableCustomField::FieldFormatPatch
      add 'combi_matrix'
      self.form_partial = 'custom_fields/formats/combi_matrix'
      self.supported_math_functions = %w[mapping]

      def label
        'label_field_format_combi_matrix'
      end

      ##
      # Orders CombiMatrixFormat fields by values of their customizable:
      #  'cf_65.value'.
      #
      # @note By default CustomFieldEnumerations are ordered by the position of
      #   the field itself: 'cf_65_combi_matrix.position'.
      #
      # @overrides Redmine::FieldFormat::EnumerationFormat#order_statement what
      #  is equal to Redmine::FieldFormat::RecordList#order_statement.
      #
      def order_statement(custom_field)
        columns_for_order_statement.map do |field|
          "#{table_for_order_statement(custom_field)}.#{field}"
        end
      end

      ##
      # Defines possible values of a combi matrix field by a pair of its name
      # and its position instead of the custom field enumeration id.
      #
      # @note This is important since combi matrix field values are stored by
      # its position rather than id.
      #
      # @overrides EnumerationFormat#possible_values_options
      #
      def possible_values_options(custom_field, object = nil)
        possible_values_records(custom_field, object).map do |item|
          [item.name, item.position.to_s]
        end
      end

      private

      def table_for_order_statement(custom_field)
        join_alias(custom_field)
      end

      def columns_for_order_statement
        ['value'].uniq
      end
    end
  end
end
