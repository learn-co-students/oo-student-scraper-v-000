class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      created_student = Student.new(student).save
    end
  end

  def new(student_hash)
    student_hash.each do |hash|
      @student = Student.new(hash)
      @student.name = hash[:name]
      @student.location = hash[:location]
    end
    student
    @@all << @student
  end

  def save
    @@all << self
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end
