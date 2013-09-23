require 'test_helper'

class RubytapasImportServiceTest < ActionView::TestCase

  def setup
    Article.delete_all
  end

  test "parse_website_paid" do
    RubyTapasImportService.new.parse_website_paid "#{Rails.root}/test/testdata/rubyTapasFeed", "#{Rails.root}/test/testdata/rubyTapasPage.html"
    assert_equal 134, Article.count
    assert_equal 118, Article.where(:free => false).count
    assert_equal 16, Article.where(:free => true).count
  end

  test "parse_website_free" do
    RubyTapasImportService.new.parse_website_free "#{Rails.root}/test/testdata/rubyTapasPage.html"
    assert_equal 16, Article.count
    assert_equal 16, Article.where(:free => true).count
  end
end
