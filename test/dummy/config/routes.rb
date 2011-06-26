Rails.application.routes.draw do
  root :to => "home#index"
  match 'omg', :to => "omg#index" # used for testing session data not sent back with assets in assets test
end
