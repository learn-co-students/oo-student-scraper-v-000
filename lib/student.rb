class Student
# gets info from the Scraper class in order to create students and add attributes
# should not call the Scraper class in any of it's methods or take it as an argument
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k,v|
      self.send(("#{k}="),v)
    end
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send(("#{k}="),v)
    end
    self
  end

  def self.all
    @@all
  end

end
