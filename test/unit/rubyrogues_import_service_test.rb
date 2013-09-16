require 'test_helper'

class RailsCastsImportServiceTest < ActionView::TestCase

  def setup
    Episode.delete_all
  end

  test "parsewebsite" do
    RubyRoguesImportService.new.parseWebsite "#{Rails.root}/test/testdata/EpisodeGuide.html"
    assert_equal 2, Episode.count
  end
end
