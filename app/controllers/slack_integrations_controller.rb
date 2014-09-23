class SlackIntegrationsController < ApplicationController

  def connect
  end

  def update
    @slack_integration = current_user.slack_integration
    @slack_integration.update(slack_integration_params(params[:slack_integration]))
    @slack_integration.save
    redirect_to slack_integrations_test_notifications_path
  end

  def options
    # raise request.env['omniauth.auth']['extra']['raw_info']['url'].inspect
    oa = request.env['omniauth.auth']['extra']['raw_info']
    @new_hash = {
      team: oa['team'].inspect,
      team_id: oa['team_id'].inspect,
      url: oa['url'].inspect,
      user: oa['user'].inspect,
      token: request.env['omniauth.auth']['credentials']['token'].inspect
    }

    # get channels to display to user



    @slack_integration = SlackIntegration.new(@new_hash)
    @slack_integration.save
    current_user.slack_integration = @slack_integration
  end

  def test_notifications
  end

  private

  def slack_integration_params(input_params)
    input_params.permit(:token, :channel, :instance_name, :new_comment, :new_idea, :new_vote, :new_community_member, :team, :team_id, :url, :user, :uid)
  end

end
