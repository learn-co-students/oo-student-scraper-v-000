class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # binding.pry
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    @@all << self

  end

  def self.create_from_collection(students_array)
    # binding.pry
    students_array.each do |student|
    Student.new(student)
      # binding.pry
    end
  end

  def add_student_attributes(attributes_hash)
    # binding.pry
    self.twitter = attributes_hash[:twitter]
    self.linkedin = attributes_hash[:linkedin]
    self.github = attributes_hash[:github]
    self.profile_url = attributes_hash[:profile_url]
    self.profile_quote = attributes_hash[:profile_quote]
    self.blog = attributes_hash[:blog]
    self.bio = attributes_hash[:bio]



  end

  def self.all
    @@all
  end
end
