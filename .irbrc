#require 'irb/completion'
# load rubygems and wirble
require 'rubygems' rescue nil
require 'irb/completion'
require 'logger'
require 'hirb'
require 'wirble'
require 'pp'
#Wirble.init
if ENV.include?('RAILS_ENV')&& !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  puts "using hirb"
  Hirb.enable
  Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
else
  puts "using wirble"
  Wirble.colorize
end
