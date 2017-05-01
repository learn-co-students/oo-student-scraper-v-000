require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash = {})
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students)

  end

  def add_student_attributes(attributes = {})
     attributes.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all

  end
end
