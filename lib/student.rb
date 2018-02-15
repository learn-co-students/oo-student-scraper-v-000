class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    if student_hash[:name] then @name = student_hash[:name]
    if student_hash[:location] then @location = student_hash[:location]
    if student_hash[:twitter] then @twitter = student_hash[:twitter]
    if student_hash[:linkedin] then @linkedin = student_hash[:linkedin]
    if student_hash[:github] then @github = student_hash[:github]
    if student_hash[:blog] then @blog = student_hash[:blog]
    if student_hash[:profile_quote] then @profile_quote = student_hash[:profile_quote]
    if student_hash[:bio] then @bio = student_hash[:bio]
    if student_hash[:profile_url] then @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    binding.pry
    students_array.each do |stud|
      Student.initialize(stud)
    end

  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
