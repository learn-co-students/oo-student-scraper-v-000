class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) #use metaprogramming to assign the newly created student attributes and values
    add_student_attributes(student_hash)
    @@all << self
    # student_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def self.create_from_collection(students_array)
    students_array.collect do |student_hash|
      Student.new(student_hash)
    end

  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def self.all
@@all
  end
end
