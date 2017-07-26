class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.location = student_hash[:location]
    self.twitter = student_hash[:twitter]
    self.linkedin = student_hash[:linkedin]
    self.github = student_hash[:github]
    self.blog = student_hash[:blog]
    self.profile_quote = student_hash[:profile_quote]
    self.profile_url = student_hash[:profile_url]
    self.name = student_hash[:name]
    self.bio = student_hash[:bio]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      Student.new(hash)
   end
  end

  def add_student_attributes(attributes_hash)
    self.location = attributes_hash[:location]
    self.twitter = attributes_hash[:twitter]
    self.linkedin = attributes_hash[:linkedin]
    self.github = attributes_hash[:github]
    self.blog = attributes_hash[:blog]
    self.profile_quote = attributes_hash[:profile_quote]
    self.profile_url = attributes_hash[:profile_url]
    self.name = attributes_hash[:name]
    self.bio = attributes_hash[:bio]
  end

  def self.all
    @@all
  end
end
