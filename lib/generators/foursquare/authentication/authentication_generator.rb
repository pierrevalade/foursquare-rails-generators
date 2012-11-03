module Foursquare
	module Generators
		class AuthenticationGenerator < Rails::Generators::Base
			include Rails::Generators::Migration
			
			source_root File.expand_path("../templates", __FILE__)

			desc "Adds Foursquare Connect to your app"
			argument :settings, type: :hash, banner: "client_id:id client_secret:secret"

			def validates_settings
				raise "incorret client_id or client_secret" if settings['client_id'].blank? || settings['client_secret'].blank?
			end

			def add_oauth2_gem
				gem 'oauth2'
			end

			# hack around https://github.com/rails/rails/pull/5139
			def self.next_migration_number(dirname)
				'20121103111300'
			end

			def create_foursquare_user_model
				migration_template 'migrations/create_foursquare_user.rb', 'db/migrate/create_foursquare_users'
				template 'models/foursquare_user.rb', File.join('app/models/', 'foursquare_user.rb')
			end

			def create_foursquare_client_model
				template 'models/foursquare_client.rb', File.join('app/models/', 'foursquare_client.rb')
			end

			def run_migrations
				rake 'db:migrate'
			end

			def create_client_controller
				template 'controllers/clients/foursquare_clients_controller.rb', File.join('app/controllers/clients', 'foursquare_clients_controller.rb')
			end

			def add_root_routes
				route "root :to => 'users#new'"
			end

			def add_clients_routes
				route(
%Q{
	scope module: 'clients' do
		resources :foursquare_clients, only: ['new'], path: 'clients/foursquare' do
		  collection do
		    get 'callback'
		  end
		end
	end
}
				)
			end

			def create_users_controller
				template 'controllers/users_controller.rb', File.join('app/controllers/', 'users_controller.rb')
			end

			def add_user_routes
				route "resource :user"
			end
		end
	end
end