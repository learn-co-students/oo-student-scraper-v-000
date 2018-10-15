class Student
require 'pry'
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self 
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
       Student.new(hash)
    end 
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute|
    
     t = attribute[0].to_s + '='
     s = t.to_sym 
     self.send(s, attribute[1])

    end 
    self 
  end

  def self.all
    @@all 
  end
end

