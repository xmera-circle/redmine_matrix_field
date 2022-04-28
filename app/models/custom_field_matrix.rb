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

class CustomFieldMatrix
  ##
  # All CustomField objects needs to have the enumeration format.
  #
  # @param base [CustomField] CustomField containing the formula
  # @param x_field [CustomField] CustomField listed first in formula
  # @param y_field [CustomField] CustomField listed second in formula
  #
  def initialize(base, x_field, y_field)
    @base = base
    @x_field = x_field
    @y_field = y_field
  end

  def valid?
    !invalid?
  end

  def invalid?
    no_fields? || no_formula? || no_matrix? || entries?
  end

  ##
  # @note The name is not valid if empty. Therefore, we use the placeholder '-'.
  #
  def prepare_new_entries
    combinations.map do |x, y|
      base.enumerations.build(x_index: x, y_index: y, name: '-')
    end
    base.save(validate: false, touch: false)
  end

  private

  attr_accessor :base, :x_field, :y_field
  attr_writer :dimensions

  def dimensions
    field_entries.map do |entries|
      entries.pluck(:position).sort
    end
  end

  def combinations
    dimensions.flatten.combination(2).to_a.uniq.sort
  end

  def field_entries
    fields.map(&:enumerations)
  end

  def fields
    [x_field, y_field]
  end

  def no_fields?
    fields.compact.empty?
  end

  def entries?
    base.enumerations.any?
  end

  def no_matrix?
    base.field_format != 'combi_matrix'
  end

  def no_formula?
    !base.formula?
  end
end
