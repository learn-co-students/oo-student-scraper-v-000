class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self

  end

  def self.create_from_collection(students_array)
    student_hash = {}
    students_array.each do |i|
      if i == :name
        student_hash[:name] = i
      elsif i = :location
        student_hash[:location] = i
      else i == :profile_url
        @profile_url = i && student_hash[:profile_url] = i
        end
        student = Student.new(student_hash)
      end
      student
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
