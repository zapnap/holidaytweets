require 'environment'
require 'tweetstream'

class TweetStreamDataAdapter
  def initialize(data)
    @data = data
  end

  def convert
    h = {}
    h[:twitter_id]  = @data.id
    h[:text]        = @data.text
    h['created_at'] = @data.created_at

    h[:from_user_name]    = @data.user.screen_name
    h[:from_user_id]      = @data.user.id
    h[:profile_image_url] = @data.user.profile_image_url

    h
  end
end

TweetStream::Daemon.new(SiteConfig.twitter_username, SiteConfig.twitter_password, 'streamer').track(*SiteConfig.search_keywords) do |status|
  s = Status.new(TweetStreamDataAdapter.new(status).convert)
  if s.save
    puts "saved status update #{s.twitter_id}"
  else
    puts "unable to save status update #{s.twitter_id}"
    puts s.errors.full_messages
  end
end
