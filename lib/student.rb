class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    # binding.pry
    
    # :name = student_hash[]
    # :location = student_hash[]
    # :twitter = student_hash[]
    # :linkedin = student_hash[]
    # :github = student_hash[]
    # :blog = student_hash[]
    # :profile_quote = student_hash[]
    # :bio = student_hash[]
    # :profile_url = student_hash[]
  end

  def self.create_from_collection(students_array)

  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
