class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @twitter = student_hash[:twitter]
    @linkedin = student_hash[:linkedin]
    @github = student_hash[:github]
    @blog = student_hash[:blog]
    @profile_quote = [:profile_quote]
    @bio = student_hash[:bio]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      @bio = value if key == :bio
      @blog = value if key == :blog
      @github = value if key == :github
      @linkedin = value if key == :linkedin
      @profile_quote = value if key == :profile_quote
      @twitter = value if key == :twitter
    end  
  end

  def self.all
    @@all
  end
end

