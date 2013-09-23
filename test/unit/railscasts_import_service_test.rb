require 'test_helper'

class RailscastsImportServiceTest < ActionView::TestCase

  def setup
    Article.delete_all
  end

  test "parse JSON with one episode, H:MM duration" do
    RailsCastsImportService.new.process_json_file "#{Rails.root}/test/testdata/OneEpisodeHMM.json"
    assert_equal 1, Article.count
    #duration is 6:00
    assert_equal 360, Article.first.duration_seconds
  end

  test "parse JSON with one episode, HH:MM duration" do
    RailsCastsImportService.new.process_json_file "#{Rails.root}/test/testdata/OneEpisodeHHMM.json"
    assert_equal 1, Article.count
    #duration is 11:06
    assert_equal 666, Article.first.duration_seconds
  end

  test "two episodes" do
    RailsCastsImportService.new.process_json_file "#{Rails.root}/test/testdata/TwoEpisodes.json"
    assert_equal 2, Article.count
  end
end
