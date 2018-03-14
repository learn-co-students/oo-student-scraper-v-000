class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @@all << self
    hash = student_hash
    @name = hash[:name]
    @location = hash[:location]
    @twitter = hash[:twitter]
    @linkedin = hash[:linkedin]
    @github = hash[:github]
    @blog = hash[:blog]
    @profile_quote = hash[:profile_quote]
    @bio = hash[:bio]
    @profile_url = hash[:profile_url]
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      new_student = Student.new(student)
      @name = student[:name]
      @location = student[:location]
      @profile_url = student[:profile_url]
    end
  end

  def add_student_attributes(attributes_hash)

    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end

    self
  end

  def self.all
    @@all
  end
end
