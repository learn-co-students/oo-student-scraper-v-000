class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    attributes = {}
    attributes = student_hash
    @name = attributes[:name]
    @location = attributes[:location]
    @@all << self
  end

  def self.create_from_collection(student_index_array)
    new_student = self.new(student_index_array[0])
    new_student.name
    new_student.location
    #binding.pry
  end

  def add_student_attributes(student_hash)
    @bio = student_hash[:bio]
    @twitter = student_hash[:twitter]
    @github = student_hash[:github]
    @blog = student_hash[:blog]
    @profile_quote = student_hash[:profile_quote]
    @linkedin = student_hash[:linkedin]
  end

  def self.all
    @@all
  end
end
