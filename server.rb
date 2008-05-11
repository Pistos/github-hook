#!/usr/bin/env ruby

# Base server code by raggi
# http://github.com/raggi/github_post_receive_server/

require 'rubygems'
require 'rack'
require 'json'
require 'pp'
require 'socket'

class App
  def self.rude_comment
    res = Rack::Response.new 
    res.write "Be gone, foul creature of the Internet." 
    res.finish
  end
  
  def self.call( env )
    req = Rack::Request.new( env )
    payload = req.POST["payload"]
    puts payload
    
    return rude_comment if req.get? or payload.nil?
    
    # Ping the Reby EventMachine listening for events
    socket = TCPSocket.new( '127.0.0.1', 9005 )
    socket.puts payload
    socket.close
    
    res = Rack::Response.new 
    res.write "Thanks! You beautiful soul, you."
    res.finish
  end

end

Rack::Handler::Mongrel.run App, :Port => 8005
