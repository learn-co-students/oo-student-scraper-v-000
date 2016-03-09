class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
      @name = student_hash[:name]
      @location = student_hash[:location]
      @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student| 
      # "student" is a single hash from the collection of hashes nested in an array
      # example: {:name=>"Alex Patriquin", :location=>"New York, NY"}
      s = self.new(student)
      @name = student[:name]
      @location = student[:location]
      @@all << s unless @@all.include?(s)
    end
  end

  #binding.pry

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      send("#{k}=", v) unless v == nil 
      # #send assigns attributes dynamically
      # this is really saying self.twitter=("someone@twitter.com")
      # in other words, self.send("twitter=", "someone@twitter.com")
    end
    self
  end

  def self.all
    @@all
  end
end

