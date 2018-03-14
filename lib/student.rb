class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    self.twitter = student_hash[:twitter]
    self.github = student_hash[:github]
    self.blog = student_hash[:blog]
    self.profile_quote = student_hash[:profile_quote]
    self.bio = student_hash[:bio]
    self.profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      new_student = Student.new(name: student[:name], location: student[:location])
      @@all << new_student
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def self.all
    @@all
  end
end

