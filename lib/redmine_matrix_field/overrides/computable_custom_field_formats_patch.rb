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

module RedmineMatrixField
  module Overrides
    module ComputableCustomFieldFormatsPatch
      def self.prepended(base)
        base.singleton_class.prepend(ClassMethods)
      end

      module ClassMethods
        def formats
          super.append('combi_matrix')
        end
      end
    end
  end
end

Rails.configuration.to_prepare do
  patch = RedmineMatrixField::Overrides::ComputableCustomFieldFormatsPatch
  klass = ComputableCustomField::Configuration
  klass.prepend patch unless klass.included_modules.include?(patch)
end