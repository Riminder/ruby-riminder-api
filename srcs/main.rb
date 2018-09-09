require 'rest-client'
require 'json'

require_relative './riminder.rb'

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

api = Riminder.new("ask_874138568ebde822652c3ddf2218333a")
resp = api.profile.json.add "profile_json" => gen_profilejson(), "source_id" => "fe6d7a2aa9125259a5ecf7905154a0396a891c06" 

puts(resp)