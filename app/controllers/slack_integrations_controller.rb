class SlackIntegrationsController < ApplicationController

  def connect
  end

  def create
    @slack_integration = SlackIntegration.new(params[:slack_integrations])
    @slack_integration.save
    current_user.slack_integration = @slack_integration
    redirect_to slack_integrations_test_notifications_path
  end

  def options
    @slack_integration = SlackIntegration.new
  end

  def test_notifications
  end

end
