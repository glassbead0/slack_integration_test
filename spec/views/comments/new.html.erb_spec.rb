require 'rails_helper'

RSpec.describe "comments/new", :type => :view do
  before(:each) do
    assign(:comment, Comment.new(
      :subject, => "MyString",
      :body, => "MyString",
      :user_id => "MyString"
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input#comment_subject,[name=?]", "comment[subject,]"

      assert_select "input#comment_body,[name=?]", "comment[body,]"

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"
    end
  end
end
