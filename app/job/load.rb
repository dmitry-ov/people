#encoding: utf-8

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
    sexes= [0] if config['sex']['man_and_woman'] == 0
   
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
    sleep 2
    criteria = "{'sex': #{value[:sex]}, 'age_from': #{value[:age]}, 'age_to': #{value[:age]}, 'country': #{config['country']}, 'cities': #{@region.id_vk}}"
    result = client.ads.get_targeting_stats( account_id: config['account']['id'], 
                                             link_url: config['link']['link_url'], 
                                             link_domain: config['link']['link_domain'], 
                                             criteria: criteria.gsub("'",'"'))
    client = nil

    key = case value[:sex]
       when 0 then "mw"+value[:age].to_s
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
      vk_api_answer = nil
    
      # 3.times do |t|
        # begin
          vk_api_answer = respond(criteria)
          # break if vk_api_answer.class.to_s == "Hash" 
      #   rescue => exception
      #     RespondLog.add(@region, DateTime.now, "error", "Ошибка запроса  Class: #{exception.class.to_s}  Message: #{exception.message.to_s}" )
      #     sleep 2
      #   end
      # end

      # raise("not connect to vk.com after 3 attepts ") unless vk_api_answer.class.to_s == "Hash"
      report.merge!(vk_api_answer)
    end
    report
  end


end
