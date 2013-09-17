require 'test_helper'

class RailscastsImportServiceTest < ActionView::TestCase

  def setup
    Episode.delete_all
  end

  test "parse JSON with one episode, H:MM duration" do
    RailsCastsImportService.new.processJsonFile "#{Rails.root}/test/testdata/OneEpisodeHMM.json"
    assert_equal 1, Episode.count
    #duration is 6:00
    assert_equal 360, Episode.first.duration_seconds
  end

  test "parse JSON with one episode, HH:MM duration" do
    RailsCastsImportService.new.processJsonFile "#{Rails.root}/test/testdata/OneEpisodeHHMM.json"
    assert_equal 1, Episode.count
    #duration is 11:06
    assert_equal 666, Episode.first.duration_seconds
  end

  test "two episodes" do
    RailsCastsImportService.new.processJsonFile "#{Rails.root}/test/testdata/TwoEpisodes.json"
    assert_equal 2, Episode.count
  end

  test "two episodes with the same RailsCasts id" do
    RailsCastsImportService.new.processJsonFile "#{Rails.root}/test/testdata/TwoEpisodesSameId.json"
    assert_equal 1, Episode.count
  end
end
