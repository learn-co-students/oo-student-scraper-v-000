class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each do |individual_student|
      Student.new(individual_student)
      @@all << self
    end
  end


  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      if key == :twitter
        self.twitter = value
      elsif key == :linkedin
        self.linkedin = value
      elsif key == github
        self.github = value
      elsif key == :profile_quote
        self.profile_quote = value
      elsif key == :bio
        self.bio = value
      elsif key == profile_url
        self.profile_url = value
      else
        self.blog = value
      end
    end
    @@all << self
  end

  def self.all
    @all
  end
end
