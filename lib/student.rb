class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
=begin (first solution for reference)
          @name = student_hash[:name]
          @location = student_hash[:location]
          @twitter = student_hash[:twitter]
          @linkedin = student_hash[:linkedin]
          @github = student_hash[:github]
          @blog = student_hash[:blog]
          @profile_quote = student_hash[:profile_quote]
          @bio = student_hash[:bio]
          @@all << self
=end    
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
    
  end

  def self.create_from_collection(students_array)

    students_array.each do |student|
      Student.new(student)
    end

  end

  def add_student_attributes(attributes_hash)

    attributes_hash.each do |symbol, value|
      instance_variable_set("@#{symbol}", value)
    end
    
  end

  def self.all
    @@all
  end
end

