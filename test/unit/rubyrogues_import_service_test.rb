require 'test_helper'

class RubyroguesImportServiceTest < ActionView::TestCase

  def setup
    Episode.delete_all
  end

  test "parsewebsite" do
    RubyRoguesImportService.new.parseWebsite "#{Rails.root}/test/testdata/EpisodeGuide.html"
    assert_equal 1, Episode.count
  end
end
