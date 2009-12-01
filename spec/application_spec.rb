require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  before(:each) do
    @status = mock('Status', :null_object => true)
    @status.stub!(:text).and_return("Here is some text")
  end

  specify 'should show the most recent status scoped to some starting status id' do
    Status.should_receive(:all).with(:limit => 1, :twitter_id.gt => '12345', :order => [:created_at]).and_return([@status])
    get '/recent.json', :since_id => '12345'
    last_response.should be_ok
    last_response.body.should == [@status].to_json
  end

  specify 'should show the most recent status' do
    Status.should_receive(:all).with(:limit => 1, :order => [:created_at.desc]).and_return([@status])
    get '/recent.json'
    last_response.should be_ok
    last_response.body.should == [@status].to_json
  end
end
