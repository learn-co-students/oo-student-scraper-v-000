class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    # student = Student.new
    #
    # properties = Scraper.new()
    #
    # Scraper.new(students_array)
    # student.each do |k,v|
    #   scraper.send("#{k}=", v)
    # end
    #
    # student
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end
