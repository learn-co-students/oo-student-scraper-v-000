class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name= student_hash[:name]
    @location = student_hash[:location]
    @@all<< self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
    self.new(student)
    
  end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.map do |key, value|
      case key
     when :twitter
       @twitter =  value
     when :linkedin
       @linkedin = value
      when :github
        @github = value
      when :blog
        @blog = value
      when :profile_quote
        @profile_quote = value
      when :bio
        @bio = value
    end
  end
  # binding.pry
  end

  def self.all
    @@all
  end
end

