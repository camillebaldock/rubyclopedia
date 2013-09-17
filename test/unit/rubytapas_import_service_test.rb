require 'test_helper'

class RubytapasImportServiceTest < ActionView::TestCase

  def setup
    Episode.delete_all
  end

  test "parseWebsitePaid" do
    RubyTapasImportService.new.parseWebsitePaid "#{Rails.root}/test/testdata/rubyTapasFeed", "#{Rails.root}/test/testdata/rubyTapasPage.html"
    assert_equal 134, Episode.count
    assert_equal 118, Episode.where(:free => false).count
    assert_equal 16, Episode.where(:free => true).count
  end

  test "parseWebsiteFree" do
    RubyTapasImportService.new.parseWebsiteFree "#{Rails.root}/test/testdata/rubyTapasPage.html"
    assert_equal 16, Episode.count
    assert_equal 16, Episode.where(:free => true).count
  end
end
