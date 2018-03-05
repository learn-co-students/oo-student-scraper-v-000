class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each_pair {|key,value| self.send("#{key}=", value)}
    @@all << self
end

  #example
  #person = Person.new
  #row.each_pair { |key, value| person.send("#{key}=", value) }

  def self.create_from_collection(students_array)
    students_array.each do|student|
    self.new(student)
    @@all << self
    end
  end


  def add_student_attributes(attributes_hash)
    attributes_hash.each do|key, value|
      self.send("#{key}=", value)
    end
  end

  def self.all
    @@all
  end

end
