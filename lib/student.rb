class Student

  attr_accessor :twitter, :linkedin, :github, :blog, :profile_quote, :bio
  # attr_accessor :name, :location, :profile_url

  @@all = []

  def initialize(student_hash)
    own_methods = self.methods - Object.methods

    student_hash.each_pair do |k, v|
      key_setter = "#{k}=".to_sym

      if !own_methods.include?(key_setter)
        # thanks to https://gist.github.com/davidbella/6918455,
        # https://www.leighhalliday.com/ruby-metaprogramming-creating-methods

        instance_var_name  = "@" + k.to_s

        # new getter
        self.class.send(:define_method, k) do
          instance_variable_get(instance_var_name)
        end

        # and a corresponding new setter
        self.class.send(:define_method, key_setter) do |new_value|
          instance_variable_set(instance_var_name, new_value)
        end
      end

      self.send(key_setter, v)
    end

    @@all << self
  end

  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end

