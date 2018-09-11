require 'riminder'
require 'filter'

require_relative 'test_helper'

RSpec.describe Filter , '#list' do
    context "Normal" do
        it "Return the result of /filters" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.filter.list
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Filter , '#get' do
    context "Normal" do
        it "Return the result of /filter" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.filter.get "filter_id" => thelper.filter_id
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Filter , '#get' do
    context "Normal with reference" do
        it "Return the result of /filter" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.filter.get "filter_reference" => thelper.filter_reference
            expect(resp).not_to eq(nil)
        end
    end
end