class CheckinsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    checkin = JSON.parse(params['checkin'])
    # TODO: verify push secret
    user = FoursquareUser.find_by_foursquare_id(checkin['user']['id'])
    user.client.create_checkin_reply(checkin['id'], text: "hello world!")
    return head :ok
  end
end