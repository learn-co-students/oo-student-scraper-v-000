class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 
  @@all = []

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="),value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(students)
    students.each{|student| Student.new(student)}
  end

  def add_student_attributes(attributes)
    attributes.each{|k,v| self.send(("#{k}="), v)}
    self
  end
end

