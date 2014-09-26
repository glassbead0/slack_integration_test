require 'rails_helper'

RSpec.describe "comments/index", :type => :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        :subject, => "Subject,",
        :body, => "Body,",
        :user_id => "User"
      ),
      Comment.create!(
        :subject, => "Subject,",
        :body, => "Body,",
        :user_id => "User"
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => "Subject,".to_s, :count => 2
    assert_select "tr>td", :text => "Body,".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
