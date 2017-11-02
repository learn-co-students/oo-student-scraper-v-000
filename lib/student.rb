class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student = {}

    @name = student_hash[:name]
    @location = student_hash[:location]

    student = student_hash

    @@all << self
    #binding.pry
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
      # @@all.each do |key, value|
      #     @name = @@all[:name]
      #    @location = @@all[:location]
    end
  end

  def add_student_attributes(attributes_hash)


    @twitter = attributes_hash[:twitter]
    @profile_quote = attributes_hash[:profile_quote]
    @linkedin = attributes_hash[:linkedin]
    @blog = attributes_hash[:blog]
    @bio = attributes_hash[:bio]
    @@all
    #binding.pry

  end
  def self.all
    @@all
  end
end
