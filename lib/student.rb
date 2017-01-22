class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(hash)
    hash.each do |k, v|
      self.send("#{k}=", v) # must be double quotes
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|hash| Student.new(hash)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    self
  end

  def self.all
    @@all
  end
end
