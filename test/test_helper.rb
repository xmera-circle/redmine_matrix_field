# frozen_string_literal: true

# This file is part of the Plugin Redmine Combination Matrix Field.
#
# Copyright (C) 2021-2023 Liane Hampe <liaham@xmera.de>, xmera Solutions GmbH.
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

require File.expand_path('../../../test/test_helper', __dir__)
require File.expand_path('../../../test/application_system_test_case', __dir__)

require File.expand_path('authenticate_user', __dir__)
require File.expand_path('fixtures_helper', __dir__)
require File.expand_path('methods_helper', __dir__)

class RedmineMatrixFieldUnitTestCase < ActiveSupport::TestCase
  include Redmine::I18n
  fixtures RedmineMatrixField::FixturesHelper.fixtures
  include RedmineMatrixField::MethodsHelper
end

class RedmineMatrixFieldControllerTestCase < ActionDispatch::IntegrationTest
  include Redmine::I18n
  fixtures RedmineMatrixField::FixturesHelper.fixtures
  include RedmineMatrixField::MethodsHelper
  include RedmineMatrixField::AuthenticateUser
end
