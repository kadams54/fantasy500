require 'test_helper'

class LeagueMailerTest < ActionMailer::TestCase
  test "membership" do
    league = create(:league, membership_digest: League.digest('join'))
    league.membership_token = League.new_token
    email = "foo@example.com"
    mail = LeagueMailer.membership(email, league)
    assert_equal "[Fantasy 500] League Membership", mail.subject
    assert_equal [email], mail.to
    assert_equal ["no-reply@fantasy500.site"], mail.from
    assert_match league.name,               mail.body.encoded
    assert_match league.membership_token,   mail.body.encoded
    assert_match league.id.to_s,            mail.body.encoded
  end
end
