class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location] #binding.pry
    @@all << self   #good lord I forgot all about this.
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| Student.new(student) } #omg. forgot about class.new too. wow. need to get more than 3 hours of sleep D:
  end

  def add_student_attributes(attributes_hash)     #binding.pry
    attributes_hash.each {|personal, value| self.send(("#{personal}="), value)}
    self #@linkedin = attributes_hash[:linkedin]
  end

  def self.all
    @@all
  end
end
