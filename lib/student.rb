
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
    
  end

  def self.create_from_collection(students_array)
    students_array.each do |new_student_info|
      student = Student.new(new_student_info)
    end
  end

  def add_student_attributes(attributes_hash)
    self.scrape_profile_page(attributes_hash)
    binding.pry
  end

  def self.all
    @@all
    
  end
end

