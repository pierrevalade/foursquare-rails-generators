module Foursquare
  module Generators
    class PushGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Receive push from foursquare into your app"

      def add_routes
        route "resources :checkins"
      end

      def create_checkins_controller
        template 'controllers/checkins_controller.rb', File.join('app/controllers/', 'checkins_controller.rb')
      end
    end
  end
end