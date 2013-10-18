Then(/^I should have "(.*?)" points$/) do |nb|
  points = nb.to_f
  @user.score.should eq(points)
end