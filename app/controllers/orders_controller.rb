require "json"
class OrdersController < ApplicationController
  post "/webhook" do
    event_json = JSON.parse(request.body.read)


    status 200
  end
end
