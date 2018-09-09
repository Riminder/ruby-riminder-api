require_relative 'riminderException.rb'


class Webhooks

    class EventNames
        EVENT_PROFILE_PARSE_SUCCESS = 'profile.parse.success'
        EVENT_PROFILE_PARSE_ERROR = 'profile.parse.error'
        EVENT_PROFILE_SCORE_SUCCESS = 'profile.score.success'
        EVENT_PROFILE_SCORE_ERROR = 'profile.score.error'
        EVENT_FILTER_TRAIN_SUCCESS = 'filter.train.success'
        EVENT_FILTER_TRAIN_ERROR = 'filter.train.error'
        EVENT_FILTER_TRAIN_START = 'filter.train.start'
        EVENT_FILTER_SCORE_SUCCESS = 'filter.score.success'
        EVENT_FILTER_SCORE_ERROR = 'filter.score.error'
        EVENT_FILTER_SCORE_START = 'filter.score.start'
        ACTION_STAGE_SUCCESS = 'action.stage.success'
        ACTION_STAGE_ERROR = 'action.stage.error'
        ACTION_RATING_SUCCESS = 'action.rating.success'
        ACTION_RATING_ERROR = 'action.rating.error'
    end

    SIGNATURE_HEADER = 'HTTP-RIMINDER-SIGNATURE'

    @clientw
    @webhook_key
    @handlers
    def initialize(clientw, webhook_key)
        @clientw = clientw
        @webhook_key = webhook_key
        @handlers = {
            EventNames.EVENT_PROFILE_PARSE_SUCCESS => nil,
            EventNames.EVENT_PROFILE_PARSE_ERROR => nil,
            EventNames.EVENT_PROFILE_SCORE_SUCCESS => nil,
            EventNames.EVENT_PROFILE_SCORE_ERROR => nil,
            EventNames.EVENT_FILTER_TRAIN_SUCCESS => nil,
            EventNames.EVENT_FILTER_TRAIN_ERROR => nil,
            EventNames.EVENT_FILTER_TRAIN_START => nil,
            EventNames.EVENT_FILTER_SCORE_SUCCESS => nil,
            EventNames.EVENT_FILTER_SCORE_ERROR => nil,
            EventNames.EVENT_FILTER_SCORE_START => nil,
            EventNames.ACTION_STAGE_SUCCESS => nil,
            EventNames.ACTION_STAGE_ERROR => nil,
            EventNames.ACTION_RATING_SUCCESS => nil,
            EventNames.ACTION_RATING_ERROR => nil,
        }
    end

    def check
       resp = @clientw.post('webhook/check')
       return resp
    end

    def setHandler(eventName, callback)
        if (!@handlers.key?(eventName))
            raise RiminderArgumentException("%s is not a valid event." [eventName])
        end
        @handlers[eventName] = callback
    end

    def removeHandler(eventName)
        if (!@handlers.key?(eventName))
            raise RiminderArgumentException("%s is not a valid event." [eventName])
        end
        @handlers[eventName] = nil
    end

    def isHandlerPresent(eventName)
        if (!@handlers.key?(eventName))
            raise RiminderArgumentException("%s is not a valid event." [eventName])
        end
        return @handlers[eventName].nil
    end

    

end