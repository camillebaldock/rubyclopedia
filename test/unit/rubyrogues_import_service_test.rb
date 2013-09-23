require 'test_helper'

class RubyroguesImportServiceTest < ActionView::TestCase

  def setup
    Article.delete_all
  end

  test "parse_website" do
    RubyRoguesImportService.new.parse_website "#{Rails.root}/test/testdata/EpisodeGuide.html"
    assert_equal 1, Article.count
  end
end
