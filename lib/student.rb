class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
      # @name = student_hash[:name]
      # @location = student_hash[:location]
      # @@all << self unless @@all.include?(self)

      # refactored to:
      self.add_student_attributes(student_hash)
      @@all << self unless @@all.include?(self)
  end

  def self.create_from_collection(students_array)
      # "student" is a single hash from the collection of hashes nested in an array
      # example: {:name=>"Alex Patriquin", :location=>"New York, NY"}

    # students_array.each do |student_hash|
      # s = self.new(student)
      # @name = student[:name]
      # @location = student[:location]
      # @@all << self unless @@all.include?(self)
    # end

      #refactored to:
    students_array.each do |student_hash| 
      Student.new(student_hash)
    end
  end

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

