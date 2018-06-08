class Student
require 'pry'
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k,v|
      if k == :name
        @name = student_hash.fetch(:name)
      elsif k == :location
        @location = student_hash.fetch(:location)
      elsif k == :twitter
        @twitter = student_hash.fetch(:twitter)
      elsif k == :linkedin
        @linkedin = student_hash.fetch(:linkedin)
      elsif k == :github
        @github = student_hash.fetch(:github)
      elsif k == :blog
        @blog = student_hash.fetch(:blog)
      elsif k == :profile_quote
        @profile_quote = student_hash.fetch(:profile_quote)
      elsif k == :bio
        @bio = student_hash.fetch(:bio)
      elsif k == :profile_url
        @profile_url = student_hash.fetch(:profile_url)
      end
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send(("#{k}="), v)
    end
    self
  end

  def self.all
    @@all
  end
end
