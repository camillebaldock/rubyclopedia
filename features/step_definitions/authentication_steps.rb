Given /^that a user exists$/ do
  @user = User.new
  @user.username = "normal"
  @user.email = "normal@rubyclopedia.com"
  @user.password = "test1234"
  @user.save!
end

Given /^that a superuser exists$/ do
  @super = User.new
  @super.username = "super"
  @super.email = "super@rubyclopedia.com"
  @user.password = "test1234"
  @super.superuser = true
  @super.save!
end

Given /^I am logged in$/ do
  visit path_to('the login page')
  fill_in('user_email', :with => @user.email)
  fill_in('user_password', :with => @user.password)
  click_button('Sign in')
  if defined?(Spec::Rails::Matchers)
    page.should have_content('Rubyclopedia is a catalogue of Ruby videos, tutorials, blog posts...')
  else
    assert page.has_content?('Rubyclopedia is a catalogue of Ruby videos, tutorials, blog posts...')
  end
end

Then /^I should see my profile$/ do
  step "I should see \"#{@user.username}\""
end