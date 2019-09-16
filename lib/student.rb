class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name] if student_hash[:name]
    @location = student_hash[:location] if student_hash[:location]
    @twitter = student_hash[:twitter] if student_hash[:twitter]
    @linkedin = student_hash[:linkedin] if student_hash[:linkedin]
    @github = student_hash[:github] if student_hash[:github]
    @blog = student_hash[:blog] if student_hash[:blog]
    @profile_quote = student_hash[:profile_quote] if student_hash[:profile_quote]
    @bio = student_hash[:bio] if student_hash[:bio]
    @profile_url = student_hash[:profile_url] if student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |stud|
      Student.new(stud)
    end

  end

  def add_student_attributes(attributes_hash)
    @name = attributes_hash[:name] if attributes_hash[:name]
    @location = attributes_hash[:location] if attributes_hash[:location]
    @twitter = attributes_hash[:twitter] if attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin] if attributes_hash[:linkedin]
    @github = attributes_hash[:github] if attributes_hash[:github]
    @blog = attributes_hash[:blog] if attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote] if attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio] if attributes_hash[:bio]
    @profile_url = attributes_hash[:profile_url] if attributes_hash[:profile_url]
  end

  def self.all
    @@all
  end
end
