Rails.application.routes.draw do
  get '/dns_records', to: 'api/v1/records#index'
  post '/dns_records', to: 'api/v1/records#create'
end
