class SlackIntegrationsController < ApplicationController
  before_action :set_slack_integration, only: [:update, :test_notifications, :new_idea, :new_comment, :new_vote, :new_community_member]

  def connect
  end

  def update
    @slack_integration.update(slack_integration_params(params[:slack_integration]))

    # set the channel id based on the channel they selected
    @channels_array = JSON.parse(Typhoeus::Request.get("https://slack.com/api/channels.list?token=#{@slack_integration.token}").body)['channels']
    @channel_id = @channels_array.select { |channel| channel['name'] == @slack_integration.channel.delete('#')}

    @slack_integration.channel_id = @channel_id[0]['id']
    @slack_integration.save
    redirect_to slack_integrations_test_notifications_path
  end

  def options
    # raise request.env['omniauth.auth']['extra']['raw_info']['url'].inspect
    if  request.env['omniauth.auth'] != nil
      oa = request.env['omniauth.auth']['extra']['raw_info']
      @new_hash = {
        team: oa['team'],
        team_id: oa['team_id'],
        url: oa['url'],
        user: oa['user'],
        token: request.env['omniauth.auth']['credentials']['token']
      }

      @slack_integration = SlackIntegration.new(@new_hash)
      @slack_integration.save
      current_user.slack_integration = @slack_integration

    else
      @slack_integration = current_user.slack_integration
    end

    # get channels to display to user
    @channels_array = JSON.parse(Typhoeus::Request.get("https://slack.com/api/channels.list?token=#{@slack_integration.token}").body)['channels']
    @channels = []


    @channels_array.each do |channel|
      @channels << '#' + channel['name']
    end

  end

  def test_notifications
  end

  def new_idea
    if @slack_integration.new_idea
      Typhoeus.get("https://slack.com/api/chat.postMessage?token=#{@slack_integration.token}&channel=#{@slack_integration.channel_id}&text=A_New_Idea_Was_Posted&username=IntegrationCzar")
    end
    redirect_to slack_integrations_test_notifications_path
  end

  def new_comment
    if @slack_integration.new_comment
      Typhoeus.get("https://slack.com/api/chat.postMessage?token=#{@slack_integration.token}&channel=#{@slack_integration.channel_id}&text=A_New_Comment_Was_Posted&username=IntegrationCzar")
    end
    redirect_to slack_integrations_test_notifications_path
  end

  def new_vote
    if @slack_integration.new_vote
      Typhoeus.get("https://slack.com/api/chat.postMessage?token=#{@slack_integration.token}&channel=#{@slack_integration.channel_id}&text=A_New_Vote_Was_Created&username=IntegrationCzar")
    end
    redirect_to slack_integrations_test_notifications_path
  end

  def new_community_member
    if @slack_integration.new_community_member
      Typhoeus.get("https://slack.com/api/chat.postMessage?token=#{@slack_integration.token}&channel=#{@slack_integration.channel_id}&text=A_New_Community_Member_Was_Added&username=IntegrationCzar")
    end
    redirect_to slack_integrations_test_notifications_path
  end

  private

  def set_slack_integration
    @slack_integration = current_user.slack_integration
  end


  def slack_integration_params(input_params)
    input_params.permit(:token, :channel, :channel_id, :instance_name, :new_comment, :new_idea, :new_vote, :new_community_member, :team, :team_id, :url, :user)
  end

end
