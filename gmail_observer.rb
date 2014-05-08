#!/usr/local/bin/ruby

def full_path(file_name)
  File.expand_path File.join(File.dirname($0), file_name)
end

ENV['BUNDLE_GEMFILE'] = full_path('Gemfile')

require 'yaml'
require 'bundler/setup'
require full_path('lib/observation.rb')
require full_path('lib/notification.rb')

setting = YAML.load_file full_path('config/setting.yml')

unless setting['mail'].nil?
  set = setting['mail']
  mail = Observation::Mail.new set['account'], set['password']
end

unless setting['growl'].nil?
  set = setting['growl']
  growl = Notification::Growl.new set['appname'], set['host'], set['password'], set['port']
end

mail.observe.each do |mail|
  growl.notify mail[:subject], "#{mail[:from]}\n#{mail[:body]}", full_path('mail.png') unless growl.nil?
end
