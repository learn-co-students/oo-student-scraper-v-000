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
    binding.pry
    @blog = student_hash[:blog]
    @twitter = student_hash[:twitter]
    @linkedin = student_hash[:linkedin]
    @profile_url = student_hash[:profile_url]
    @profile_quote = student_hash[:profile_quote]
    @github = student_hash[:github]
    @bio = student_hash[:bio]

  end

  def self.all
    @@all
  end
end
