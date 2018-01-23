class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      created_student = Student.new(student).save
    end
  end

  def new(student_hash)
    student_hash.each do |hash|
      student = Student.new(hash)
      student.name = hash[:name]
      student.location = hash[:location]
    end
    student
    @@all << @student
  end

  def save
    @@all << self
  end

  def add_student_attributes(attributes_hash)
    # use the Scraper class to get a hash of a given student's attributes and uses that hash to set additional attributes for that students
    # so probably want to call scrape_profile_page for this one
    # need to check to see if an instance of that student already exists by saying something like if @@all includes student.name, then update the existing array of hashes, if not create it with these attributes_hash

    # scraper class is wanting a URL.... I need to build a different type of scraper based off the scrape profile page one that can take this hash as the arguments instead of the URL before. won't need to use nokogiri for this one, since we're not going out anywhere. Thinking it'll be more like the scrape_profile_page as the template since I already have those attributes in the argument being passed.






    # attributes_hash.each do |student|

  end

  def self.all
    @@all
  end
end
