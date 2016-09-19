require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    self.twitter = student_hash[:twitter]
    self.linkedin = student_hash[:linkedin]
    self.github = student_hash[:github]
    self.blog = student_hash[:blog]
    self.profile_quote = student_hash[:profile_quote]
    self.bio = student_hash[:bio]
    self.profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|stu_hash| Student.new(stu_hash)}
  end

  def add_student_attributes(attributes_hash)
      self.name ||= attributes_hash[:name]
      self.location ||= attributes_hash[:location]
      self.twitter ||= attributes_hash[:twitter]
      self.linkedin ||= attributes_hash[:linkedin]
      self.github ||= attributes_hash[:github]
      self.blog ||= attributes_hash[:blog]
      self.profile_quote ||= attributes_hash[:profile_quote]
      self.bio ||= attributes_hash[:bio]
      self.profile_url ||= attributes_hash[:profile_url]
  end

  def self.all
    @@all
  end
end
