class SlackIntegration
  include Mongoid::Document
  belongs_to :user

  field :channel,               type: String,   default: '#general'
  field :new_idea,              type: Boolean,  default: false
  field :new_comment,           type: Boolean,  default: false
  field :new_vote,              type: Boolean,  default: false
  field :new_community_member,  type: Boolean,  default: false

end
