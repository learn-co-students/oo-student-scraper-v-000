class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
    # uses .send to make a more robust way of creating the key elements of the has and its value based on what's given in the
    # student hash.
    # adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable
    student_hash.each do |key, value|
      self.send("#{key}=",value)
  end
    @@all << self
  end

  def self.create_from_collection(students_array)
    # uses the Scraper class to create new students with the correct name and location.
    students_array.each {|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    # uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional
    # Uses .send to create take the attributes from the hash and add them to the instance we're in.
     attributes_hash.each do |key,value|
        # attributes for that student.
        self.send("#{key}=",value)
   end
  end

  def self.all
    @@all
   end
  end
