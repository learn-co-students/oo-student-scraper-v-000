require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
  # student_hash.each {|key, value| self.send(("#{key}="), value)} 
  self.name = student_hash[:name]
  self.location = student_hash[:location]

  @@all << self
  end

  def self.create_from_collection(students_array)
    #binding.pry
    students_array.each do |student|
      Student.new(student)
    end

  end

  def add_student_attributes(attributes_hash)
# binding.pry
# attributes_hash.each {|key, value| self.send(("#{key}="), value)} 

# attributes_hash.each do |e|
#   self.e = attributes_hash[:e]

self.twitter = attributes_hash[:twitter]
self.linkedin = attributes_hash[:linkedin]
self.github = attributes_hash[:github]
self.blog = attributes_hash[:blog]
self.profile_quote = attributes_hash[:profile_quote]
self.bio = attributes_hash[:bio]
    @@all << attributes_hash
   end

  def self.all
@@all
  end
end
