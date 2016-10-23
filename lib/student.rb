require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each { |student|
      self.new(student)
    }
  end

  def add_student_attributes(attributes_hash)
    keys = []
    values = []
    attributes_hash.each { |key, value| keys << key; values << value }
    for i in 0..keys.size - 1
      #binding.pry
      case keys[i].to_s
      when "twitter"
        @twitter = values[i]
      when "linkedin"
        @linkedin = values[i]
      when "profile_quote"
        @profile_quote = values[i]
      when "profile_url"
        @profile_url = values[i]
      when "blog"
        @blog = values[i]
      when "bio"
        @bio = values[i]
      end
    end
  end

  def self.all
    @@all
  end
end
