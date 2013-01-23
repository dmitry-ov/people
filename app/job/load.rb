class Load
  @@path = "#{Rails.root}/config/vk_api.yaml"


  def initialize(region)
    raise("value region not class region") unless region.class.to_s == "Region"
    @region = region
  end


  def config
    raise("file #{@@path} dont exist") unless File.exist?(@@path)   
    @@vk_api_connection_param ||= YAML.load_file(@@path)
  end


  def make_criterias 
    sexes = []
    sexes << config['sex']['man'] << config['sex']['woman']

    age_from, age_to = config['age']['from'], config['age']['to']

    ages=[]
    age_from.upto(age_to) do |n|
      ages << n 
    end
      
    criterias = []
    sexes.each do |sex|
        ages.each do |age|
          criterias << {sex: sex, age: age}
        end
    end
    
    criterias
  end


  def respond(value)
    client = VkontakteApi::Client.new(config['account']['secret_token'])
    criteria = "{'sex': #{value[:sex]}, 'age_from': #{value[:age]}, 'age_to': #{value[:age]}, 'country': #{config['country']}, 'city': #{@region.id_vk}}"
    result = client.ads.get_targeting_stats( account_id: config['account']['id'], link_url: config['link']['link_url'], link_domain: config['link']['link_domain'], criteria: criteria.gsub("'",'"'))

    key = case value[:sex]
       when 1 then "m"+value[:age].to_s
       when 2 then "w"+value[:age].to_s
       else raise("Invalid value sex in config file")
    end
    puts result["audience_count"] #DEBUG  
    {key => result["audience_count"]}        
  end


  def report
    criterias = make_criterias

    report = {}
    criterias.each do |criteria|
      vk_api_answer = respond(criteria) 
      report.merge!(vk_api_answer)
      sleep 2
    end
    report
  end


end
