class AppNotification < ApplicationRecord
  has_many :read_app_notifications, dependent: :destroy

  validates_presence_of :date, :notification_type, :title, :content
end
