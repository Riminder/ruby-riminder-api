require 'riminder'
require 'source'

require_relative 'test_helper'

RSpec.describe Source , '#list' do
    context "Normal" do
        it "Return the result of /sources" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.source.list
            expect(resp).not_to eq(nil)
        end
    end
end

RSpec.describe Source , '#get' do
    context "Normal" do
        it "Return the result of /sources" do
            thelper = TestHelper.new()
            api = Riminder.new(thelper.api_key)
            resp = api.source.get thelper.source_id
            expect(resp).not_to eq(nil)
        end
    end
end