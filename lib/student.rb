class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def self.all
    @@all
  end

  def initialize(student_hash)
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.instance_variable_set("@#{key}", value)}
  end

end
