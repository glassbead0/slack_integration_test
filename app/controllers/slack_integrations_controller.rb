class SlackIntegrationsController < ApplicationController

  def connect
  end

  def create
    @slack_integration = current_user.slack_integration
    @slack_integration.update(slack_integration_params)
    @slack_integration.save
    redirect_to slack_integrations_test_notifications_path
  end

  def options
    @slack_integration = SlackIntegration.new(token: params[:code])
    @slack_integration.save
    current_user.slack_integration = @slack_integration
  end

  def test_notifications
  end

  private

  def slack_integration_params
    params[:slack_integration].permit(:token, :channel, :instance_name, :new_comment, :new_idea, :new_vote, :new_community_member)
  end

end
