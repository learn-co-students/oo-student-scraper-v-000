class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      new_instance = Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @bio = attributes_hash[:bio]
    @profile_quote = attributes_hash[:profile_quote]
  end

  def self.all
    @@all
  end
end
