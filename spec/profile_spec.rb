require 'riminder'
require 'profile'

require_relative 'test_helper'

RSpec.describe Profile , '#list' do
    context "Normal min args" do
        it "Return the result of /profiles" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.list "source_ids" => [thelper.source_id]
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#list' do
    context "Normal max args no filter" do
        it "Return the result of /profiles" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.list "source_ids" => [thelper.source_id],
            "date_start" => 1505129838, "date_end" => Time.now.to_i,
            "page" => 2, "sort_by" => "ranking", "seniority" => 'all', 
            "limit" => 3, "order_by" => 'asc'
            res = !resp.nil? && resp["profiles"].length <= 3
            expect(res).to be true
        end
    end
end

RSpec.describe Profile , '#list' do
    context "Normal max args with filter reference" do
        it "Return the result of /profiles" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.list "source_ids" => [thelper.source_id],
            "date_start" => 1505129838, "date_end" => Time.now.to_i,
            "page" => 2, "sort_by" => "ranking", "seniority" => 'all', 
            "limit" => 3, "order_by" => 'asc', "filter_id" => thelper.filter_id,
            "stage" => 'NEW', "rating" => '1' 
            res = !resp.nil? && resp["profiles"].length <= 3
            expect(res).to be true
        end
    end
end

RSpec.describe Profile , '#list' do
    context "Normal max args with filter id" do
        it "Return the result of /profiles" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.list "source_ids" => [thelper.source_id],
            "date_start" => 1505129838, "date_end" => Time.now.to_i,
            "page" => 2, "sort_by" => "ranking", "seniority" => 'all', 
            "limit" => 3, "order_by" => 'asc', "filter_reference" => thelper.filter_reference,
            "stage" => 'NEW', "rating" => '1' 
            res = !resp.nil? && resp["profiles"].length <= 3
            expect(res).to be true
        end
    end
end

RSpec.describe Profile , '#add' do
    context "Normal min arg" do
        it "Return the result of /profile" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.add "filepath" => thelper.cv_test_path, "source_id" => thelper.source_id
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#add' do
    context "Normal max arg" do
        it "Return the result of /profile" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.add "filepath" => thelper.cv_test_path, "source_id" => thelper.source_id,
            "profile_reference" => rand(99999).to_s, "timestamp_reception" => Time.now.to_i, "training_metadata" => thelper.gen_trainingmetadata()
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#json.add' do
    context "Normal min arg" do
        it "Return the result of /profile/json" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.json.add "profile_json" => thelper.gen_profilejson(), "source_id" => thelper.source_id
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#json.add' do
    context "Normal max arg" do
        it "Return the result of /profile/json" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.json.add "profile_json" => thelper.gen_profilejson(), "source_id" => thelper.source_id,
            "profile_reference" => rand(99999).to_s, "timestamp_reception" => Time.now.to_i, "training_metadata" => thelper.gen_trainingmetadata()
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#json.check' do
    context "Normal min arg" do
        it "Return the result of /profile/json/check" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.json.check "profile_json" => thelper.gen_profilejson()
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#json.check' do
    context "Normal max arg" do
        it "Return the result of /profile/json/check" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.json.check "profile_json" => thelper.gen_profilejson(), "training_metadata" => thelper.gen_trainingmetadata()
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#get' do
    context "Normal" do
        it "Return the result of /profile" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.get "source_id" => thelper.source_id, "profile_id" => thelper.profile_id
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#get' do
    context "Normal with profile_reference" do
        it "Return the result of /profile" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.get "source_id" => thelper.source_id, "profile_reference" => thelper.profile_reference
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Profile , '#document.list' do
    context "Normal" do
        it "Return the result of /profile/document" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.document.list "source_id" => thelper.source_id, "profile_id" => thelper.profile_id
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#document.list' do
    context "Normal with profile_reference" do
        it "Return the result of /profile/document" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.document.list "source_id" => thelper.source_id, "profile_reference" => thelper.profile_reference
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Profile , '#parsing.get' do
    context "Normal" do
        it "Return the result of /profile/parsing" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.parsing.get "source_id" => thelper.source_id, "profile_id" => thelper.profile_id
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#parsing.get' do
    context "Normal with profile_reference" do
        it "Return the result of /profile/parsing" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.parsing.get "source_id" => thelper.source_id, "profile_reference" => thelper.profile_reference
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Profile , '#scoring.list' do
    context "Normal" do
        it "Return the result of /profile/scoring" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.scoring.list "source_id" => thelper.source_id, "profile_id" => thelper.profile_id
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#scoring.list' do
    context "Normal with profile_reference" do
        it "Return the result of /profile/scoring" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.scoring.list "source_id" => thelper.source_id, "profile_reference" => thelper.profile_reference
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Profile , '#stage.set' do
    context "Normal" do
        it "Return the result of /profile/stage" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.stage.set "source_id" => thelper.source_id, "profile_id" => thelper.profile_id, "filter_id" => thelper.filter_id, "stage" => "NO"
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#stage.set' do
    context "Normal with profile_reference" do
        it "Return the result of /profile/stage" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.stage.set "source_id" => thelper.source_id, "profile_reference" => thelper.profile_reference, "filter_reference" => thelper.filter_reference, "stage" => "NO"
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Profile , '#rating.set' do
    context "Normal" do
        it "Return the result of /profile/rating" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.rating.set "source_id" => thelper.source_id, "profile_id" => thelper.profile_id, "filter_id" => thelper.filter_id, "rating" => 1
            expect(resp).not_to eq(nil)
        end
    end
end 

RSpec.describe Profile , '#rating.set' do
    context "Normal with profile_reference" do
        it "Return the result of /profile/rating" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.profile.rating.set "source_id" => thelper.source_id, "profile_reference" => thelper.profile_reference, "filter_reference" => thelper.filter_reference, "rating" => 1
            expect(resp).not_to eq(nil)
        end
    end
end