class Student

  attr_accessor :name, :location, :twitter, :linkedin, :facebook, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.keys.each do |key|
        send( "#{key}=", student_hash[key] )
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    
    students_array.each {|h| @@all << self.new(h)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| send( "#{key}=", value ) }
  end

  def self.all
    @@all
  end
end

