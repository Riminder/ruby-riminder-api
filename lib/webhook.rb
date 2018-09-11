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
        @handlers = {}
    
        @handlers[EventNames::EVENT_PROFILE_PARSE_SUCCESS] = nil
        @handlers[EventNames::EVENT_PROFILE_PARSE_ERROR] = nil
        @handlers[EventNames::EVENT_PROFILE_SCORE_SUCCESS] = nil
        @handlers[EventNames::EVENT_PROFILE_SCORE_ERROR] = nil
        @handlers[EventNames::EVENT_FILTER_TRAIN_SUCCESS] = nil
        @handlers[EventNames::EVENT_FILTER_TRAIN_ERROR] = nil
        @handlers[EventNames::EVENT_FILTER_TRAIN_START] = nil
        @handlers[EventNames::EVENT_FILTER_SCORE_SUCCESS] = nil
        @handlers[EventNames::EVENT_FILTER_SCORE_ERROR] = nil
        @handlers[EventNames::EVENT_FILTER_SCORE_START] = nil
        @handlers[EventNames::ACTION_STAGE_SUCCESS] = nil
        @handlers[EventNames::ACTION_STAGE_ERROR] = nil
        @handlers[EventNames::ACTION_RATING_SUCCESS] = nil
        @handlers[EventNames::ACTION_RATING_ERROR] = nil
    end

    def check
       resp = @clientw.post('webhook/check')
       return resp["data"]
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

    def getEncodedHeader(receivedMessage)
        if (receivedMessage.is_a?(Hash))
            if (receivedMessage.key?(SIGNATURE_HEADER))
                return receivedMessage[SIGNATURE_HEADER]
            end
            raise RiminderArgumentException.new("Webhhook request header should contain %s key." [SIGNATURE_HEADER])
        end
        return receivedMessage
    end

    def customstrstr(inp, to_replace, by)
        res = ""
        inp.each_char {|c|
            tmpc = c
            tr_idx = to_replace.index(tmpc)
            if (!tr_idx.nil? && by.length < tr_idx)
                    tmpc = by[tr_idx]
            end
            res = res + tmpc
        }
        return res
    end

    def base64urlDecode(inp)
        return Base64.decode64(customstrstr(inp, "-_", "+/"))
    end

    def isSignatureValid(payload, sign)
        expectedsign = OpenSSL::HMAC.digest("SHA256", @webhook_key, payload)
        return expectedsign == sign
    end

    def handle(receivedMessage)
        if (@webhook_key.blank?)
            raise RiminderWebhookException.new("No webhook secret key provided")
        end
        encodedMessage = getEncodedHeader(receivedMessage)
        tmp = encodedMessage.split('.', 2)
        sign = base64urlDecode(tmp[0])
        json_payload = base64urlDecode(tmp[1])

        if (!isSignatureValid(json_payload, sign))
            raise RiminderWebhookException.new("Invalid signature")
        end
        payload = JSON.parse(json_payload)
        
        payloadtype = payload['type']
        if (payloadtype.nil? || !@handlers.key?(payloadtype))
            raise RiminderWebhookException.new("Null or absent webhook type.")
        end
        
        callback = @handlers[payloadtype]
        if (!callback.nil?)
            callback.call(payloadtype, payload)
        end
    end
end