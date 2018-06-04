class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name=student_hash[:name]
    @location=student_hash[:location]
    profile_suffix=@name.downcase.sub(" ","-")
    @profile_url="students/#{profile_suffix}.html"
    #binding.pry
    @@all<<self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      student=Student.new(student_hash)
      #binding.pry
    end
  end

  def add_student_attributes(attributes_hash)
    @bio=attributes_hash[:bio]
    @profile_quote=attributes_hash[:profile_quote]
    @twitter=attributes_hash[:twitter]
    @linkedin=attributes_hash[:linkedin]
    @blog=attributes_hash[:blog]
    @github=attributes_hash[:github]
  end

  def self.all
    @@all
  end
end
