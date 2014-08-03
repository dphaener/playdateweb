Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users' => 'users#index', :as => nil
    end
  end
end
