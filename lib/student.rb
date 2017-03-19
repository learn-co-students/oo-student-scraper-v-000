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
    students_array.each do |s|
      Student.new(s)
    end
  end

  def add_student_attributes(attributes_hash)
    binding.pry
#(attributes_hash)
#=> {:twitter=>"someone@twitter.com",
 #:linkedin=>"someone@linkedin.com",
 #:github=>"someone@github.com",
 #:blog=>"someone@blog.com",
 #:profile_quote=>
  #{}"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
 #:bio=>
  #{}"I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and
  #Tokyo for elementary/middle school."}
    attributes_hash.each do |k,v|
      self.send("#{k}=", v)
    end
  end
  
  def self.all
    @@all
  end
end
