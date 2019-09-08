class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #binding.pry
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    #binding.pry
    students_array.each { |hash| Student.new(hash) }
  end

  def add_student_attributes(attributes_hash)
    #binding.pry
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @bio = attributes_hash[:bio]
    @profile_quote = attributes_hash[:profile_quote]
  end

  def self.all
    @@all
  end
end
