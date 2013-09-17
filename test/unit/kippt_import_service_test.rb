require 'test_helper'

class KipptImportServiceTest < ActionView::TestCase

  def setup
    Episode.delete_all
  end

  test "parseFeed" do
    KipptImportService.new.parseFeed "#{Rails.root}/test/testdata/kipptFeed"
    assert_equal 2, Episode.count
  end
end
