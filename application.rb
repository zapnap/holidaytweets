require 'rubygems'
require 'sinatra'
require 'environment'

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

get '/recent.json' do
  options = if params[:since_id]
    { :limit => 1, :twitter_id.gt => params[:since_id], :order => [:created_at] }
  else
    { :limit => 1, :order => [:created_at.desc] }
  end

  @statuses = Status.all(options)
  @statuses.to_json
end
