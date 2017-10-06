require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    if student_hash.has_key?(:name)
      @name = student_hash[:name]
    end
    if student_hash.has_key?(:location)
      @location = student_hash[:location]
    end
    if student_hash.has_key?(:twitter)
      @twitter = student_hash[:twitter]
    end
    if student_hash.has_key?(:linkedin)
      @linkedin = student_hash[:linkedin]
    end
    if student_hash.has_key?(:github)
      @github = student_hash[:github]
    end
    if student_hash.has_key?(:blog)
      @blog = student_hash[:blog]
    end
    if student_hash.has_key?(:profile_url)
      @profile_url = student_hash[:profile_url]
    end
    if student_hash.has_key?(:bio)
      @bio = student_hash[:bio]
    end
    if student_hash.has_key?(:profile_quote)
      @profile_quote = student_hash[:profile_quote]
    end

    @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      student = Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    if attributes_hash.has_key?(:name)
      @name = attributes_hash[:name]
    end
    if attributes_hash.has_key?(:location)
      @location = attributes_hash[:location]
    end
    if attributes_hash.has_key?(:twitter)
      @twitter = attributes_hash[:twitter]
    end
    if attributes_hash.has_key?(:linkedin)
      @linkedin = attributes_hash[:linkedin]
    end
    if attributes_hash.has_key?(:github)
      @github = attributes_hash[:github]
    end
    if attributes_hash.has_key?(:blog)
      @blog = attributes_hash[:blog]
    end
    if attributes_hash.has_key?(:profile_url)
      @profile_url = attributes_hash[:profile_url]
    end
    if attributes_hash.has_key?(:bio)
      @bio = attributes_hash[:bio]
    end
    if attributes_hash.has_key?(:profile_quote)
      @profile_quote = attributes_hash[:profile_quote]
    end
  end

  def self.all
    @@all
  end
end
