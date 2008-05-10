#!/usr/bin/env ruby

# Base server code by raggi

require 'rubygems'
require 'rack'
require 'json'
require 'pp'

class App
  def self.rude_comment
    res = Rack::Response.new 
    res.write "Be gone, foul creature of the internet." 
    res.finish
  end
  
  def self.call( env )
    req = Rack::Request.new( env )
    payload = req.POST["payload"]
    
    return rude_comment if req.get? or payload.nil?
    
    payload = JSON.parse( payload )
    puts payload.pretty_inspect
    
    res = Rack::Response.new 
    res.write "Thanks! You beautiful soul you."
    res.finish
  end

end

Rack::Handler::Mongrel.run App, :Port => 8005
