class Comment
  include Mongoid::Document
  belongs_to :user
  field :subject,   type: String
  field :body,      type: String
  field :user_id,   type: String

  after_create(:send_comment_to_slack)

  def send_comment_to_slack

    if current_user.slack_integraion && current_user.slack_integration.new_comment
      Typhoeus.get("https://slack.com/api/chat.postMessage?token=#{@slack_integration.token}&channel=#{@slack_integration.channel_id}&text=A_New_Comment_Was_Posted&username=IntegrationCzar")
    end
    redirect_to slack_integrations_test_notifications_path
  end
end
