require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Carl Seator", email: "carl.seator@lullaby.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should be < 256 chars" do
    @user.name = "a" * 300
    assert_not @user.valid?
  end

  test "email should be < 256 chars" do
    @user.email = "a" * 250 + "@test.com"
    assert_not @user.valid?
  end

  test "email should have a @" do
    @user.email = "not_an.email"
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate = @user.dup
    @user.save
    assert_not duplicate.valid?
  end

  test "password should not be blank" do
    @user.password = "" * 6
    @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end

  test "password should be >= 6 chars" do
    @user.password = "1234"
    @user.password_confirmation = "1234"
    assert_not @user.valid?
  end
end
