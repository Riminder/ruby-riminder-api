require_relative './riminder.rb'

api = Riminder.new("haha")

resp = api.filter.list()
puts(resp)

