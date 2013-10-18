class SubmissionMailer < ActionMailer::Base
  default from: 'ruby@camillebaldock.co.uk'
 
  def submission_accepted(submission, article)
  	@submission = submission
  	@article = article
    mail(to: submission.user.email, subject: 'Your submission to the Rubyclopedia has been accepted')
  end

  def submission_refused(submission)
  	@submission = submission
  	mail(to: submission.user.email, subject: 'Your submission to the Rubyclopedia has been refused')
  end
end