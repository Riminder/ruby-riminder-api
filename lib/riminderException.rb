class RiminderException < StandardError
    def initialize(msg)
        super(msg)
    end
end

class RiminderArgumentException < RiminderException
    def initialize(msg)
        super(msg)
    end
end

class RiminderWebhookException < RiminderException
    def initialize(msg)
        super(msg)
    end
end

class RiminderTransfertException < RiminderException
    def initialize(msg, exp)
        msg = msg + exp.to_s + ' => ' + exp.backtrace.to_s
        super(msg)
    end
end

class RiminderResponseException < RiminderException
    attr_reader :response_body
    attr_reader :status_code

    def initialize(msg, exp)
        response_body = exp.http_body
        if (response_body.length >= 201)
            response_body = response_body.str[0, 200] + '...'
        end
        msg = msg + exp.to_s + " => " + response_body

        @response_body = exp.http_body
        @status_code = exp.http_code
        super(msg)
    end
end
