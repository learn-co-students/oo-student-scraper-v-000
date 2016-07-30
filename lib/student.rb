class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
  @@all = []

  # takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
  def initialize(student_hash)
    student_hash.each do |title, string|
     self.send("#{title}=", string)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      self.new(student_hash) # mass assignment It's taking a hash with key and value pairs as arguments
      # and setting them equal to the attributes that the class has
      # handing it off to initialize
    end
  end

  def add_student_attributes(attributes_hash)
     # uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.
    attributes_hash.each do |key, value|
       # if key is equal to the classes attribute then set that attribute equal to it's value
      if key == :bio
        @bio = value
      elsif key == :blog
        @blog = value
      elsif key == :linkedin
        @linkedin = value
      elsif key == :profile_quote
        @profile_quote = value
      elsif key == :twitter
        @twitter = value
     end
    end
  end

  def self.all
    @@all
    # binding.pry
  end
end
