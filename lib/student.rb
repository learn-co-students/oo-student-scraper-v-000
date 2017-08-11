require "pry"

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash.values_at(:name).join
    @location = student_hash.values_at(:location).join
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    self.twitter = attributes_hash.values_at(:twitter).join
    self.linkedin = attributes_hash.values_at(:linkedin).join
    self.github = attributes_hash.values_at(:github).join
    self.blog = attributes_hash.values_at(:blog).join
    self.profile_quote = attributes_hash.values_at(:profile_quote).join
    self.bio = attributes_hash.values_at(:bio).join
  end

  def self.all
    @@all
  end
end

