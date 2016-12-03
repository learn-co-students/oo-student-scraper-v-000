class Student
  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  @@all = []

  def initialize(hash)
    @name = hash[:name]
    @location = hash[:location]
    @profile_url = hash[:profile_url]
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      student = self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio]
  end


end
