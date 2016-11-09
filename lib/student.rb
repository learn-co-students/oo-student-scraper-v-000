require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    self.profile_url = student_hash[:profile_url]
    self.twitter = student_hash[:twitter] if student_hash[:twitter]
    self.linkedin = student_hash[:linkedin] if student_hash[:linkedin]
    self.github = student_hash[:github] if student_hash[:github]
    self.blog = student_hash[:blog] if student_hash[:blog]
    self.profile_quote = student_hash[:profile_quote] if student_hash[:profile_quote]
    self.bio = student_hash[:bio] if student_hash[:bio]
    send
  end

  def send
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.map do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    self.twitter = attributes_hash[:twitter] if attributes_hash[:twitter]
    self.linkedin = attributes_hash[:linkedin] if attributes_hash[:linkedin]
    self.github = attributes_hash[:github] if attributes_hash[:github]
    self.blog = attributes_hash[:blog] if attributes_hash[:blog]
    self.profile_quote = attributes_hash[:profile_quote] if attributes_hash[:profile_quote]
    self.bio = attributes_hash[:bio] if attributes_hash[:bio]
  end

  def self.all
    @@all
  end
end
