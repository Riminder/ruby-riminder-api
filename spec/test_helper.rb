
require 'json'


require 'webhook'

class TestHelper

    attr_reader :api_key
    attr_reader :webhook_key
    attr_reader :profile_id
    attr_reader :profile_reference
    attr_reader :source_id
    attr_reader :filter_id
    attr_reader :filter_reference
    attr_reader :cv_test_path
    def initialize
        @api_key = 'ask_874138568ebde822652c3ddf2218333a'
        @webhook_key = 'valid_key_haha'
        @profile_id = 'be50e7e57f4ad045ac8c406e7b665d409be9e363'
        @profile_reference = '5279'
        @source_id = 'fe6d7a2aa9125259a5ecf7905154a0396a891c06'
        @filter_id = '050bdaa9cedad3cf2bc2fac3e4e4acb7499d762a'
        @filter_reference = '1234567'
        @cv_test_path = 'test_asset/cv_test01.jpg'
    end

    def gen_profilejson()
        pjson = {
            "name" => 'Magalie Desktest',
            "email" => 'magalie.desktest@gmail.com',
            "phone" => '+33743457894',
            "summary" => 'I the world greatest philosopher',
            "location_details" => {
                "text" => "Moon"
            },
            "experiences" => [
                {
                    "start" => "23/05/2010",
                    "end" => "",
                    "title" => "The Philosopher",
                    "company" => "Moon thinker",
                    "location" => nil,
                    "location_details" => {
                        "text" => "Moon"
                    },
                    "description" => "Chief of all philosophers"
                }
            ],
            "educations" => [
                {
                    "start" => "23/05/2005",
                    "end" => "2/04/2010",
                    "title" => "Philosophy",
                    "school" => "Moon school",
                    "location" => nil,
                    "location_details" => {
                        "text" => "Moon"
                    },
                    "description" => ""
                }
            ],
            "skills" => ["diplomacy", "Politics", "speech"],
            "languages" => ["english", "chinese", "french", "Swedish"],
            "interests" => ["jumping", "speaking", "video games", "sports"],
            "urls" => {
                "from_resume" => [],
                "linkedin" => nil,
                "twitter" => nil,
                "facebook" => nil,
                "github" => nil,
                "picture" => nil
            }
        }
        return pjson
    end

    def gen_trainingmetadata()
        tmeta = [
            {
                "filter_reference" => @filter_reference,
                "stage" => "NO",
                "stage_timestamp" => "1536619600",
                "rating" => "3",
                "rating_timestamp" => "1536619600"
            }
        ]
        return tmeta
    end

    def gen_webhookEncodedMessage()
        payload = {
            'type' => Webhooks::EventNames::EVENT_PROFILE_PARSE_SUCCESS,
            'somedatas' => 'thedatas'
        }

        payload_json = payload.to_json
        sign = OpenSSL::HMAC.digest("SHA256", @webhook_key, payload_json)
        b64sign = Base64.encode64(sign)
        b64payload = Base64.encode64(payload_json)
        return b64sign + '.' + b64payload
    end

end