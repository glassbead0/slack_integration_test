require 'rails_helper'

RSpec.describe "comments/show", :type => :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :subject, => "Subject,",
      :body, => "Body,",
      :user_id => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject,/)
    expect(rendered).to match(/Body,/)
    expect(rendered).to match(/User/)
  end
end
