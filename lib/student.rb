require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do|key, value|
       self.send(("#{key}="), value)
       #binding.pry
     end
    @@all << self
    #binding.pry
  end

  def self.create_from_collection(students_array)
    #binding.pry
    students_array.each do |student|
      self.new(student)
      #student[:name]
      #student.map {|s| student[:name]}
      #binding.pry
    end
  end

  # def self.create
  #
  # end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do|key, value|
       self.send(("#{key}="), value)
    #   #binding.pry
     end
  end

  def self.all
    @@all
  end
end
