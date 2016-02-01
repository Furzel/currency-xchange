require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "should not signup without a name" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "test@test.com",
                               password: "password",
                               password_confirmation: "password" }
    end
    assert_template 'users/new'
  end

  test "should not signup without an email" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "Tester",
                               email: "",
                               password: "password",
                               password_confirmation: "password" }
    end
    assert_template 'users/new'
  end

  test "should not signup with an invalid email" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "Tester",
                               email: "not_an.email",
                               password: "password",
                               password_confirmation: "password" }
    end
    assert_template 'users/new'
  end

  test "should not signup without a password" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "Tester",
                               email: "test@test.com",
                               password: "",
                               password_confirmation: "password" }
    end
    assert_template 'users/new'
  end

  test "should not signup with an invalid password" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "Tester",
                               email: "test@test.com",
                               password: "pass",
                               password_confirmation: "pass" }
    end
    assert_template 'users/new'
  end

  test "should allow signup with correct informations" do 
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "Tester",
                               email: "test@test.com",
                               password: "password",
                               password_confirmation: "password" }
    assert_template 'users/show'
  end
end
