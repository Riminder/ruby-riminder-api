require_relative 'requtils.rb'

class Filter
    @clientw

    def initialize(clientw)
        @clientw = clientw
    end

    def list()
        resp = @clientw.get("filters")
        return resp
    end

    def get(options)
        query = {}
        query = ReqUtils.add_if_not_blank(query, 'filter_id', options['filter_id'])
        query = ReqUtils.add_if_not_blank(query, 'filter_reference', options['filter_reference'])
        resp = @clientw.get("filter", query)
        return resp
    end
end