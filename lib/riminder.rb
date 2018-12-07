require_relative 'restClientW.rb'
require_relative 'source.rb'
require_relative 'filter.rb'
require_relative 'profile.rb'
require_relative 'webhook.rb'

class Riminder
    @api_key
    @webhook_key
    @base_url
    @clientw
    attr_reader :source
    attr_reader :filter
    attr_reader :profile
    attr_reader :webhooks

    def initialize(api_key, webhook_key=nil, base_url='https://www.riminder.net/sf/public/api/v1.0/')
        @api_key = api_key
        @webhook_key = webhook_key
        @base_url = base_url
        headrs = {'X-API-KEY' => api_key}
        @clientw = RestClientW.new(base_url, headrs)

        @source = Source.new(@clientw)
        @filter = Filter.new(@clientw)
        @profile = Profile.new(@clientw)
        @webhooks = Webhooks.new(@clientw, webhook_key)

    end

end
