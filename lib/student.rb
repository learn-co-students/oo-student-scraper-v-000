class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
<<<<<<< HEAD
    @name = student_hash[:name]
=======
    @name = student_hash[:name] 
>>>>>>> 159305738d0891170841dcfd353198d6c1f698cc
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
      students_array.each do |student_hash|
        Student.new(student_hash)
      end

  end

  def add_student_attributes(attributes_hash)
<<<<<<< HEAD
      @twitter = attributes_hash[:twitter]
      @linkedin = attributes_hash[:linkedin]
      @github = attributes_hash[:github]
      @blog = attributes_hash[:blog]
      @profile_quote = attributes_hash[:profile_quote]
      @bio = attributes_hash[:bio]
=======
      @twitter = attributes_hash[:twitter] 
      @linkedin = attributes_hash[:linkedin] 
      @github = attributes_hash[:github] 
      @blog = attributes_hash[:blog]
      @profile_quote = attributes_hash[:profile_quote] 
      @bio = attributes_hash[:bio] 
>>>>>>> 159305738d0891170841dcfd353198d6c1f698cc
  end

  def self.all
    @@all
  end
end
