require 'test_helper'

class KipptImportServiceTest < ActionView::TestCase

  def setup
    Article.delete_all
  end

  test "parseFeed" do
    KipptImportService.new.parse_feed "#{Rails.root}/test/testdata/kipptFeed"
    assert_equal 2, Article.count
  end
end
