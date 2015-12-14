class SampleStruct

  def initialize hash

    hash.each do |key,value|

      self.class.send(:define_method, "#{key}=".to_sym) do |value|
        instance_variable_set("@" + key.to_s, value)
      end

      self.class.send(:define_method, key.to_sym) do
        instance_variable_get("@" + key.to_s)
      end

      self.send("#{key}=".to_sym, value)
      
    end
    
  end

end
