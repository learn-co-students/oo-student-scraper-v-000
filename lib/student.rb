require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_h|
      Student.new(student_h)
    end
  end

  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter] unless  !attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin] unless !attributes_hash[:linkedin]
    @github = attributes_hash[:github] unless !attributes_hash[:github]
    @blog = attributes_hash[:blog] unless !attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote] unless !attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio] unless !attributes_hash[:bio]
    @profile_url = attributes_hash[:profile_url] unless !attributes_hash[:profile_url]
    #@ = attributes_hash[]

  end

  def self.all
    @@all
  end
end
