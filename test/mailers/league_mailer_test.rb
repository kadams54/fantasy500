require 'test_helper'

class LeagueMailerTest < ActionMailer::TestCase
  test "mambership" do
    mail = LeagueMailer.mambership
    assert_equal "Mambership", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
