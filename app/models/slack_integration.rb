class SlackIntegration
  include Mongoid::Document
  belongs_to :user

  field :token,                 type: String
  field :channel,               type: String
  field :instance_name,         type: String
  field :new_idea,              type: Boolean,  default: false
  field :new_comment,           type: Boolean,  default: false
  field :new_vote,              type: Boolean,  default: false
  field :new_community_member,  type: Boolean,  default: false
  field :user_id,               type: String
end
