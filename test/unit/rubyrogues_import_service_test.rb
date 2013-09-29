require 'test_helper'

class RubyroguesImportServiceTest < ActionView::TestCase

  def setup
    Article.delete_all
  end

  test "parse_website" do
    RubyRoguesImportService.new.parse_website "#{Rails.root}/test/testdata/EpisodeGuide.html"
    RubyRoguesImportService.should_receive(:process_response).exactly(1).times
  end

  test "process_response" do
    RubyRoguesImportService.new.process_response "#{Rails.root}/test/testdata/001rubyrogues.html"
    assert_equal 1, Article.count
  end
end
