class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each { |student| Student.new(student) }
  end

  def add_student_attributes(attributes_hash)
    @blog = attributes_hash[:blog]
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @profile_url = attributes_hash[:profile_url]
    @profile_quote = attributes_hash[:profile_quote]
    @github = attributes_hash[:github]
    @bio = attributes_hash[:bio]
  end

  def self.all
    @@all
  end
end
