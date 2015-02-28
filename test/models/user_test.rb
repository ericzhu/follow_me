require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name:'Example User', email: 'user@example.com')
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = '    '
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = 'abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabc'
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
						aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
						aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
						aaaaaaaaaaa@example.com"
		assert_not @user.valid?
	end

	test "email validation should accept only valid address" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]

		valid_addresses.each do |address|
			@user.email = address
			assert @user.valid?, "#{address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid address" do
		valid_addresses = %w[user@example,com USER#foo.COM A_US-ER$foo.bar.org first.last_foo.jp alice+bob_baz.cn]

		valid_addresses.each do |address|
			@user.email = address
			assert_not @user.valid?, "#{address.inspect} should be invalid"
		end
	end

	test "email address should be unique" do
		duplcated_user = @user.dup
		@user.save
		assert_not duplcated_user.valid?
	end

	test "email address should be downcased in db" do
		@user.email = "HELLO@EMAIL.COM"
		@user.save

		assert_equal User.first.email, "HELLO@EMAIL.COM".downcase

	end
end
