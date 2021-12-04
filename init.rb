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

require 'redmine_matrix_field'

Redmine::Plugin.register :redmine_matrix_field do
  name 'Combination Matrix Field'
  author 'Liane Hampe'
  description 'Combination matrix as computable custom field with colored background'
  version '0.1.1'
  url 'https://circle.xmera.de/projects/redmine-matrix-field'
  author_url 'http://xmera.de'

  requires_redmine version_or_higher: '4.2.1'
  requires_redmine_plugin :redmine_colored_enumeration, version_or_higher: '0.1.0'
  requires_redmine_plugin :redmine_computable_custom_field, version_or_higher: '3.0.1'
end
