#encoding: utf-8

class StatisticController < ApplicationController
  def index
    @statistic = Statistic.all
    # render :template => 'statistic/index'
    
  end
  
  def json
    @s = Statistic.first

    hash_to_view = { :region => @s.region.name } 
    h = @s.hashvalue    
       
    man, woman = [], []

    0.upto(19) do |i|
       man << (-1)*(h["m#{i*5+1}"].to_i + h["m#{i*5+2}"].to_i + h["m#{i*5+3}"].to_i + h["m#{i*5+4}"].to_i + h["m#{i*5+5}"].to_i)
       woman << h["w#{i*5+1}"].to_i + h["w#{i*5+2}"].to_i + h["w#{i*5+3}"].to_i + h["w#{i*5+4}"].to_i + h["w#{i*5+5}"].to_i
    end 

    hash_to_view.merge!({:man => man })
    hash_to_view.merge!({:woman => woman })

    render :json => hash_to_view.to_json
    
    # render :json => '{"man" : [-1746181, -1884428, -2089758, -2222362, -2537431, -2507081, -2443179,
    #                 -2664537, -3556505, -3680231, -3143062, -2721122, -2229181, -2227768,
    #                 -2176300, -1329968, -836804, -354784, -90569, -28367, -3878],
    #                  "woman" : [1656154, 1787564, 1981671, 2108575, 2403438, 2366003, 2301402, 2519874,
    #                 3360596, 3493473, 3050775, 2759560, 2304444, 2426504, 2568938, 1785638,
    #                 1447162, 1005011, 330870, 130632, 21208], "region": "Курская"}'
  end

end
