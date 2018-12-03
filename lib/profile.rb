require 'json'
require_relative 'riminderException.rb'

class Profile
    @clientw
    attr_reader :document
    attr_reader :parsing
    attr_reader :scoring
    attr_reader :json
    attr_reader :stage
    attr_reader :rating
    attr_reader :reveal
    DEFAULT_DATE_START = '1347209668'

    def initialize(clientw)
        @clientw = clientw

        @document = Documents.new(@clientw)
        @parsing = Parsing.new(@clientw)
        @scoring = Scoring.new(@clientw)
        @json = Json.new(@clientw)
        @stage = Stage.new(@clientw)
        @rating = Rating.new(@clientw)
        @reveal = Reveal.new(@clientw)

    end

    def add(options)
        if (!options.key?('filepath'))
            raise RiminderArgumentException.new('A filepath should be given')
        end
        file_path = options['filepath']
        payload = {
            'source_id' => options['source_id']
        }
        payload = ReqUtils.add_if_not_blank(payload, 'profile_reference', options['profile_reference'])
        payload = ReqUtils.add_if_not_blank(payload, 'timestamp_reception', options['timestamp_reception'])
        payload = ReqUtils.add_if_not_blank(payload, 'training_metadata', ReqUtils.validateTrainingMetadata(options['training_metadata']))
        resp = @clientw.postfile('profile', file_path, payload)
        return resp["data"]
    end


    def get(options)
        query = {
            "source_id" => options['source_id']
        }
        query = ReqUtils.add_if_not_blank(query, 'profile_id', options['profile_id'])
        query = ReqUtils.add_if_not_blank(query, 'profile_reference', options['profile_reference'])
        resp = @clientw.get("profile", query)
        return resp["data"]
    end

    def list(options)
        if (!options['source_ids'].nil? && !options['source_ids'].kind_of?(Array))
            raise RiminderArgumentException.new('options should contains a the source_ids field a an Array')
        end
        query = {
            'source_ids' => options['source_ids'].to_json,
            'date_start' => DEFAULT_DATE_START,
            'date_end' => Time.now.to_i,
            'page' => 1,
            'sort_by' => 'ranking'
        }
        query = ReqUtils.add_if_not_blank(query, 'seniority', options['seniority'])
        query = ReqUtils.add_if_not_blank(query, 'filter_id', options['filter_id'])
        query = ReqUtils.add_if_not_blank(query, 'filter_reference', options['filter_reference'])
        query = ReqUtils.add_if_not_blank(query, 'stage', options['stage'])
        query = ReqUtils.add_if_not_blank(query, 'rating', options['rating'])
        query = ReqUtils.add_if_not_blank(query, 'date_start', options['date_start'])
        query = ReqUtils.add_if_not_blank(query, 'date_end', options['date_end'])
        query = ReqUtils.add_if_not_blank(query, 'page', options['page'])
        query = ReqUtils.add_if_not_blank(query, 'limit', options['limit'])
        query = ReqUtils.add_if_not_blank(query, 'sort_by', options['sort_by'])
        query = ReqUtils.add_if_not_blank(query, 'order_by', options['order_by'])

        resp = @clientw.get('profiles', query)
        return resp["data"]
    end

    class Documents
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def list(options)
            query = {
                "source_id" => options['source_id']
            }
            query = ReqUtils.add_if_not_blank(query, 'profile_id', options['profile_id'])
            query = ReqUtils.add_if_not_blank(query, 'profile_reference', options['profile_reference'])
            resp = @clientw.get("profile/documents", query)
            return resp["data"]
        end
    end

    class Parsing
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def get(options)
           query = {
                "source_id" => options['source_id']
            }
            query = ReqUtils.add_if_not_blank(query, 'profile_id', options['profile_id'])
            query = ReqUtils.add_if_not_blank(query, 'profile_reference', options['profile_reference'])
            resp = @clientw.get("profile/parsing", query)
            return resp["data"]
        end 
    end

    class Scoring
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def list(options)
           query = {
                "source_id" => options['source_id']
            }
            query = ReqUtils.add_if_not_blank(query, 'profile_id', options['profile_id'])
            query = ReqUtils.add_if_not_blank(query, 'profile_reference', options['profile_reference'])
            resp = @clientw.get("profile/scoring", query)
            return resp['data']
        end 
    end

    class Json
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def check(options)
            payload = {
                "profile_json" => options['profile_json'] 
            }
            payload = ReqUtils.add_if_not_blank(payload, 'training_metadata', ReqUtils.validateTrainingMetadata(options['training_metadata']))
            resp = @clientw.post('profile/json/check', payload)
            return resp['data']
        end

        def add(options)
            payload = {
                "source_id" => options['source_id'],
                "profile_json" => options['profile_json'] 
            }
            payload = ReqUtils.add_if_not_blank(payload, 'profile_reference', options['profile_reference'])
            payload = ReqUtils.add_if_not_blank(payload, 'timestamp_reception', options['timestamp_reception'])
            payload = ReqUtils.add_if_not_blank(payload, 'training_metadata', ReqUtils.validateTrainingMetadata(options['training_metadata']))
            resp = @clientw.post('profile/json', payload)
            return resp['data']
        end
    end

    class Stage
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def set(options)
            payload = {
                "source_id" => options['source_id'],
                "stage" => options["stage"]
            }
            payload = ReqUtils.add_if_not_blank(payload, 'profile_id', options['profile_id'])
            payload = ReqUtils.add_if_not_blank(payload, 'profile_reference', options['profile_reference'])
            payload = ReqUtils.add_if_not_blank(payload, 'filter_id', options['filter_id'])
            payload = ReqUtils.add_if_not_blank(payload, 'filter_reference', options['filter_reference'])
            resp = @clientw.patch("profile/stage", payload)
            return resp['data']
        end
    end

    class Rating
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def set(options)
            payload = {
                "source_id" => options['source_id'],
                "rating" => options["rating"]
            }
            payload = ReqUtils.add_if_not_blank(payload, 'profile_id', options['profile_id'])
            payload = ReqUtils.add_if_not_blank(payload, 'profile_reference', options['profile_reference'])
            payload = ReqUtils.add_if_not_blank(payload, 'filter_id', options['filter_id'])
            payload = ReqUtils.add_if_not_blank(payload, 'filter_reference', options['filter_reference'])
            resp = @clientw.patch("profile/rating", payload)
            return resp['data']
        end
    end

    class Reveal
        @clientw
        def initialize(clientw)
            @clientw = clientw
        end

        def get(options)
            payload = {
                "source_id" => options['source_id']
            }
            payload = ReqUtils.add_if_not_blank(payload, 'profile_id', options['profile_id'])
            payload = ReqUtils.add_if_not_blank(payload, 'profile_reference', options['profile_reference'])
            payload = ReqUtils.add_if_not_blank(payload, 'filter_id', options['filter_id'])
            payload = ReqUtils.add_if_not_blank(payload, 'filter_reference', options['filter_reference'])
            resp = @clientw.get("profile/interpretability", payload)
            return resp['data']
        end
    end

end