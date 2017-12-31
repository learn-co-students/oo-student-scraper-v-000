class Student

  attr_accessor :name, :location, :twitter, :linkedin,
  :github, :blog, :profile_quote, :bio, :profile_url
#collection of all existing students
  @@all = []

  def initialize(student_hash)
#takes in an argument of a hash and sets that new student's
#attributes using the key/value pairs of that hash.
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
#adds that new student to the Student class' collection of
#all existing students, stored in the `@@all` class variable.
    @@all << self
  end

#uses the Scraper class to create new students with the
#correct name and location.
  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end



  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end

end
