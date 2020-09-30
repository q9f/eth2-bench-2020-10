#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

@HOST = "127.0.0.1"
@PORT = 3500
@METR = 8080
@DATA = "/data/prysm/beaconchaindata/"

def get_peer_count
	begin
		uri = URI.parse("http://#{@HOST}:#{@PORT}/eth/v1alpha1/node/peers")
		response = Net::HTTP.get_response(uri)
		peer_count = JSON.parse(response.body)["peers"].size
	rescue
		peer_count = -9
	end
end

def get_slot_height
	begin
		uri = URI.parse("http://#{@HOST}:#{@PORT}/eth/v1alpha1/beacon/chainhead")
		response = Net::HTTP.get_response(uri)
		slot_height = JSON.parse(response.body)["headSlot"].to_i
	rescue
		slot_height = -9
	end
end

def get_database_size
	begin
		database_size = `du -bs #{@DATA} 2> /dev/null`.to_i
	rescue
		database_size = -9
	end
end

def get_memory_usage
  memory_usage = -7
	begin
		uri = URI.parse("http://#{@HOST}:#{@METR}/metrics")
		response = Net::HTTP.get_response(uri)
		response.body.each_line do |metric|
			if not metric[0].include? "#" and metric.include? "process_resident_memory_bytes"
				memory_usage = metric.split(" ").last.to_f.to_i
		  end
	  end
	rescue
		memory_usage = -9
	end
	memory_usage
end

def get_unix_time
	Time.now.utc.to_i
end

print "time,db,mem,slot,bps,peers\n"

loop do
	t = get_unix_time
	c = get_peer_count
	h = get_slot_height
	s = get_database_size
	m = get_memory_usage

	print "#{t},#{s},#{m},#{h},#{c}\n"

	sleep 1
end
