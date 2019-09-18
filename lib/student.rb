class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      student = Student.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    # self.twitter = attributes_hash[:twitter] if attributes_hash[:twitter]
    # self.linkedin = attributes_hash[:linkedin] if attributes_hash[:linkedin]
    # self.github = attributes_hash[:github] if attributes_hash[:github]
    # self.blog = attributes_hash[:blog] if attributes_hash[:blog]
    # self.profile_quote = attributes_hash[:profile_quote] if attributes_hash[:profile_quote]
    # self.bio = attributes_hash[:bio] if attributes_hash[:bio]
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end
