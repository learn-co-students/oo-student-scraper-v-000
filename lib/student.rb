class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []


  #class will use info returned by Scraper to create students and add attributes
  #SHOULD NOT call on the scraper class or its methods
  #class should be dependent of where its gets its information

  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)}
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k, v| self.send(("#{k}="), v)}
    self
  end

  def self.all
    @@all
  end
end
