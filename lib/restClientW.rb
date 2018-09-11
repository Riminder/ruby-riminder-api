require 'rest-client'
require 'json'

require_relative 'riminderException.rb'

class RestClientW

    @base_url
    @base_headers
    def initialize(base_url, headers)
        @base_headers = headers
        @base_url = base_url    
    end

    def fill_header_params_for_get(params)
        headrs = {}
        headrs["params"] = params
        @base_headers.each_pair {|key, value| headrs[key] = value}
        return headrs
    end

    def get(path, params={})
        url = @base_url + path
        headrs = fill_header_params_for_get(params)
        
        resp = nil
        begin
            resp = RestClient::Request.execute(:method => :get, :url => url, :headers => headrs)
        rescue RestClient::ExceptionWithResponse => exp
            raise RiminderResponseException.new("Invalid Response: ", exp)
        rescue RestClient::Exception => exp
            raise RiminderTransfertException.new("Error during transfert: ", exp)
        end
        return JSON.parse(resp)
    end

    def post(path, payload={})
        url = @base_url + path

        json_payload = payload.to_json
        begin
            resp = RestClient.post url, json_payload, @base_headers
        rescue RestClient::ExceptionWithResponse => exp
            raise RiminderResponseException.new("Invalid Response: ", exp)
        rescue RestClient::Exception => exp
            raise RiminderTransfertException.new("Error during transfert: ", exp)
        end

        return JSON.parse(resp)
    end

    def fill_postfile_multipart(multipart, payload)
        payload.each_pair {|key, value| multipart[key] = value }
        return multipart
    end

    def postfile(path, file_path, payload={})
        url = @base_url + path
        
        multipart = {:file => File.new(file_path, 'rb'), :multipart => true}
        multipart = fill_postfile_multipart(multipart, payload)
        
        begin
            resp = RestClient.post url, multipart, @base_headers
        rescue RestClient::ExceptionWithResponse => exp
            raise RiminderResponseException.new("Invalid Response: ", exp)
        rescue RestClient::Exception => exp
            raise RiminderTransfertException.new("Error during transfert: ", exp)
        end
        return JSON.parse(resp)
    end

    def patch(path, payload={})
        url = @base_url + path

        json_payload = payload.to_json
        begin
            resp = RestClient.patch url, json_payload, @base_headers
        rescue RestClient::ExceptionWithResponse => exp
            raise RiminderResponseException.new("Invalid Response: ", exp)
        rescue RestClient::Exception => exp
            raise RiminderTransfertException.new("Error during transfert: ", exp)
        end
        return JSON.parse(resp)
    end
        
end