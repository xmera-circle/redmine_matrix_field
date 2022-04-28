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

class MappingFunction < BaseFunction
  include Redmine::I18n

  def calculate
    values
    map = custom_field.enumerations.where(x_index: values[0], y_index: values[1]).take
    map&.position
  end

  def available_operators
    []
  end

  def available_delimiters
    %w[,]
  end

  def available_signs
    []
  end

  ##
  # Returning -1 means no restrictions.
  #
  def max_num_of_fields
    2
  end
end
