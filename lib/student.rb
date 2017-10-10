class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all<<self
  end

  def self.create_from_collection(students_array) # uses the Scraper class to create new students with the correct name and location.
    students_array.each do |student_hash|
      Student.new(student_hash)
  end

  def add_student_attributes(attributes_hash) # uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all #Student .all returns the class variable @@all
    @@all
  end

end
end
