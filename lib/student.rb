require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []
  
  def self.all
    @@all
  end

  def initialize(student_hash)
    @name = student_hash[:name] if student_hash[:name]
    @location = student_hash[:location] if student_hash[:location]
    @twitter = student_hash[:twitter] if student_hash[:twitter]
    @linkedin = student_hash[:linkedin] if student_hash[:linkedin]
    @github = student_hash[:github] if student_hash[:github]
    @blog = student_hash[:blog] if student_hash[:blog]
    @profile_quote = student_hash[:profile_quote] if student_hash[:profile_quote]
    @bio = student_hash[:bio] if student_hash[:bio]
    @profile_url = student_hash[:profile_url] if student_hash[:profile_url]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  
end

