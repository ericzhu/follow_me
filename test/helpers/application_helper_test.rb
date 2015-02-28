require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, 'Follow Me'
		assert_equal full_title('Help'), 'Help | Follow Me'
	end
end