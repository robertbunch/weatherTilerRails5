Rails.application.routes.draw do
	root to: 'city_weathers#index'
  resources :city_weathers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
