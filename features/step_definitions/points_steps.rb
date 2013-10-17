Then(/^I should have "(.*?)" points$/) do |nb|
  p "This is what I have"
  p @user.score
  p nb
  points = nb.to_f
  @user.score.should eq(points)
end