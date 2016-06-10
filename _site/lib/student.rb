class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key,value| 
      if key == :name
        @name = value
      elsif key == :location
        @location = value
      elsif key == :twitter
        @twitter = value
      elsif key == :linkedin
          @linkedin = value
        elsif key == :github
          @github = value
        elsif key == :blog
          @blog = value
        elsif key == :profile_quote
          @profile_quote = value
        elsif key == :bio
          @bio = value
        else key == :profile_url
          @profile_url = value
        end
      end
      @@all << self
    end

  def self.create_from_collection(students_array)
     students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end

