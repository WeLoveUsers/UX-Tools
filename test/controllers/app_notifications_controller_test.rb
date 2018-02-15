require 'test_helper'

class AppNotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_notification = app_notifications(:one)
  end

  test "should get index" do
    get app_notifications_url
    assert_response :success
  end

  test "should get new" do
    get new_app_notification_url
    assert_response :success
  end

  test "should create app_notification" do
    assert_difference('AppNotification.count') do
      post app_notifications_url, params: { app_notification: { content: @app_notification.content, date: @app_notification.date, notification_type: @app_notification.notification_type, title: @app_notification.title } }
    end

    assert_redirected_to app_notification_url(AppNotification.last)
  end

  test "should show app_notification" do
    get app_notification_url(@app_notification)
    assert_response :success
  end

  test "should get edit" do
    get edit_app_notification_url(@app_notification)
    assert_response :success
  end

  test "should update app_notification" do
    patch app_notification_url(@app_notification), params: { app_notification: { content: @app_notification.content, date: @app_notification.date, notification_type: @app_notification.notification_type, title: @app_notification.title } }
    assert_redirected_to app_notification_url(@app_notification)
  end

  test "should destroy app_notification" do
    assert_difference('AppNotification.count', -1) do
      delete app_notification_url(@app_notification)
    end

    assert_redirected_to app_notifications_url
  end
end
