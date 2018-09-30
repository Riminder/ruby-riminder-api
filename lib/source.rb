
class Source
    @clientw

    def initialize(clientw)
        @clientw = clientw
    end

    def list()
        resp = @clientw.get("sources")
        return resp['data']
    end

    def get(source_id)
        query = {
            "source_id" => source_id
        }
        resp = @clientw.get("source", query)
        return resp['data']
    end
end