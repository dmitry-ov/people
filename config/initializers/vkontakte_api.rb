VkontakteApi.configure do |config|
  # Authorization parameters (not needed when using an external authorization):
  # config.app_id       = '3303641'
  # config.app_secret   = '727450551296d527eebcd5e6014ac80ca3e76256355d1c06dbeea929c023c5d8e09c58b9f6aa0075681e2'
  # config.redirect_uri = 'http://vkpeople.ru'

  # Faraday adapter to make requests with:
  config.adapter = :net_http
  
   config.faraday_options = { 
     proxy: { 
       uri:'http://fw1:8080',
       user: 'ovcharenko',
       password: 'g3TPdp'
     }
   }  

  # HTTP verb for API methods (:get or :post)
  config.http_verb = :get
  
  # Logging parameters:
  # log everything through the rails logger
  config.logger = Rails.logger
  
  # log requests' URLs
  # config.log_requests = true
  
  # log response JSON after errors
  # config.log_errors = true
  
  # log response JSON after successful responses
  # config.log_responses = false
end

# create a short alias VK for VkontakteApi module
# VkontakteApi.register_alias
