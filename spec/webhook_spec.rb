require 'riminder'
require 'webhook'
require 'riminderException'

require_relative 'test_helper'

RSpec.describe Webhooks , '#check' do
    context "Normal" do
        it "Return the result of /webhook/check" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.webhooks.check
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Webhooks , '#handle' do
    context "Normal" do
        it "call webhook callback for an event" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key, thelper.webhook_key)
            validate_by_callback = false

            cb  = -> (event_type, event_data) {
                if (event_type == Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS)
                    validate_by_callback = true
                end
            }
            api.webhooks.setHandler Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS, cb

            encodedHeader = thelper.gen_webhookEncodedMessage()
            api.webhooks.handle encodedHeader
            expect(validate_by_callback).to be true
        end
    end
end

RSpec.describe Webhooks , '#handle' do
    context "with Hash header" do
        it "call webhook callback for an event" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key, thelper.webhook_key)
            validate_by_callback = false

            cb  = -> (event_type, event_data) {
                if (event_type == Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS)
                    validate_by_callback = true
                end
            }
            api.webhooks.setHandler Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS, cb

            encodedHeader = thelper.gen_webhookEncodedMessage()
            api.webhooks.handle Webhooks::SIGNATURE_HEADER => encodedHeader
            expect(validate_by_callback).to be true
        end
    end
end

RSpec.describe Webhooks , '#handle' do
    context "with no handler" do
        it "call webhook callback for an event" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key, thelper.webhook_key)
            validate_by_callback = false

            encodedHeader = thelper.gen_webhookEncodedMessage()
            api.webhooks.handle Webhooks::SIGNATURE_HEADER => encodedHeader
            expect(validate_by_callback).to be false
        end
    end
end

RSpec.describe Webhooks , '#handle' do
    context "with removed handler" do
        it "call webhook callback for an event" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key, thelper.webhook_key)
            validate_by_callback = false

            cb  = -> (event_type, event_data) {
                if (event_type == Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS)
                    validate_by_callback = true
                end
            }
            api.webhooks.setHandler Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS, cb

            encodedHeader = thelper.gen_webhookEncodedMessage()

            api.webhooks.removeHandler(Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS)
            api.webhooks.handle Webhooks::SIGNATURE_HEADER => encodedHeader
            expect(validate_by_callback).to be false
        end
    end
end

RSpec.describe Webhooks , '#handle' do
    context "with bad key" do
        it "call webhook callback for an event" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key, "LOL")
            validate_by_exp = false
            validate_by_callback = false

            cb  = -> (event_type, event_data) {
                if (event_type == Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS)
                    validate_by_callback = true
                end
            }
            api.webhooks.setHandler Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS, cb

            encodedHeader = thelper.gen_webhookEncodedMessage()

            begin
                api.webhooks.handle Webhooks::SIGNATURE_HEADER => encodedHeader
            rescue => riminderWebhookException
                validate_by_exp = true
            end
            expect(validate_by_exp).to be true
        end
    end
end