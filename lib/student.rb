class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # student_hash.each do |student|
      @name = student_hash[:name]
      @location = student_hash[:location]
      # @profile_url = student[:profile_url]
      @profile_url = student_hash[:profile_url]
    # end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
     self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    @bio = attributes_hash[:bio]
    @profile_quote = attributes_hash[:profile_quote]
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
  end

  def self.all
    @@all
  end
end


