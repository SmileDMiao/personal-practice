namespace :foods do

  desc '批量创建food表记录'
  task :create_batch_foods => :environment do
    category = ['浆果类','柑橘类','核果类','仁果类','瓜类','其他']
    details = [
    ['草莓','蓝莓','黑莓','桑葚','覆盆子','葡萄','青提','红提','水晶葡萄','马奶子'],

    ['蜜橘','砂糖橘','金橘','蜜柑','甜橙','脐橙','西柚','柚子','葡萄柚','柠檬','文旦','莱姆'],

    ['油桃','蟠桃','水蜜桃','黄桃','李子','樱桃','杏','梅子','杨梅','西梅','乌梅','大枣','沙枣','海枣','蜜枣','橄榄','荔枝','龙眼','槟榔'],

    ['苹果','梨','蛇果','海棠果','沙果','柿子','山竹','黑布林','枇杷','杨桃','山楂','圣女果','无花果','白果','罗汉果','火龙果','猕猴桃'],

    ['西瓜','美人瓜','甜瓜','香瓜','黄河蜜','哈密瓜','木瓜','乳瓜'],

    ['菠萝','芒果','栗子','椰子','奇异果','芭乐','榴莲','香蕉','甘蔗','百合','莲子','石榴','核桃','拐枣']
    ]
    food_hash = {}
    i = 0
    category.each do |c|
      food_hash[c] = details[i]
      i = i + 1
    end

    food_hash.each do |key,value|
      value.each do |name|
        food = Food.new(:name => name,
                    :category => key,
                    :color => random_color,
                    :number => random_number,
                    :price => random_price,
                    :country => '中国')
        food.save
      end
    end
    puts 'success'
  end


  private
  #随机颜色
  def random_color
    "#"+rand(255).to_s(16)+rand(255).to_s(16)+rand(255).to_s(16)
  end

  #随机浮点数
  def random_price
    Random.rand(30) + Random.rand
  end

  #随机整数
  def random_number
    Random.rand(100)
  end

end
