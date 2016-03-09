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
      s = self.new(student)
      @name = student[:name]
      @location = student[:location]
      @@all << s unless @@all.include?(s)
    end
  end

  #binding.pry

  def add_student_attributes(attributes_hash)

    @twitter = attributes_hash[:twitter] unless attributes_hash[:twitter] == nil
    @linkedin = attributes_hash[:linkedin] unless attributes_hash[:linkedin] == nil
    @github = attributes_hash[:github] unless attributes_hash[:github] == nil
    @blog = attributes_hash[:blog] unless attributes_hash[:blog] == nil
    @profile_quote = attributes_hash[:profile_quote] unless attributes_hash[:profile_quote] == nil
    @bio = attributes_hash[:bio] unless attributes_hash[:bio] == nil
    @profile_url = attributes_hash[:profile_url] unless attributes_hash[:profile_url] == nil
    self
  end

  def self.all
    @@all
  end
end

