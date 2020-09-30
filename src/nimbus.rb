#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

@HOST = "127.0.0.1"
@PORT = 9090
@METR = 8090
@DATA = "/data/nimbus/db/"

def get_peer_count
	begin
		uri = URI.parse("http://#{@HOST}:#{@PORT}")
		request = Net::HTTP::Post.new(uri)
		request.content_type = "application/json"
		request.body = JSON.dump({
			"jsonrpc" => "2.0",
			"id" => "13",
			"method" => "getNetworkPeers",
			"params" => []
		})
		req_options = {
			use_ssl: uri.scheme == "https"
		}
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			http.request(request)
		end
		peer_count = JSON.parse(response.body)["result"].size
	rescue
		peer_count = -9
	end
end

def get_slot_height
	begin
		uri = URI.parse("http://#{@HOST}:#{@PORT}")
		request = Net::HTTP::Post.new(uri)
		request.content_type = "application/json"
		request.body = JSON.dump({
			"jsonrpc" => "2.0",
			"id" => "14",
			"method" => "getBeaconHead",
			"params" => []
		})
		req_options = {
			use_ssl: uri.scheme == "https"
		}
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			http.request(request)
		end
		slot_height = JSON.parse(response.body)["result"].to_i
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
