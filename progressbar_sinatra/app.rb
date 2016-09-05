require 'sinatra'
require 'sqlite3'
require 'pry'
require 'json'
require 'active_record'
require 'pusher'
require 'config_env'
ConfigEnv.init("#{__dir__}/config/env.rb")

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]

get '/' do
  erb :index
end

post '/create_account_with_realtime' do
  name = params[:name]
  uid = params[:uid]
  pusher_channel = "signup_process_#{uid}"
  fake_background_job(name, pusher_channel)
  redirect to("/finished")
end

def fake_background_job(name, pusher_channel)
  Pusher.trigger(pusher_channel, 'update', { message: "Starting provisioning your account #{name}", progress: 30 })
  sleep(3)
  Pusher.trigger(pusher_channel, 'update', { message: "Sorry, #{name}, it's taking a bit of time...", progress: 30 })
  sleep(2)
  Pusher.trigger(pusher_channel, 'update', { message: "almost there, adding the demo data...", progess: 60 })
  sleep(4)
  Pusher.trigger(pusher_channel, 'update', { message: "Polishing your new account...", progress: 90 })
  sleep(3)
  Pusher.trigger(pusher_channel, 'update', { message: "Everything is ready for you #{name}! Does it feel like 12 seconds?", progress: 100 })
end

get "/finished" do
  erb :finished
end
