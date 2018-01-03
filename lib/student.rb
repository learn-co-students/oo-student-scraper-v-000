class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @twitter = student_hash[:twitter]
    @linked_in = student_hash[:linked_in]
    @github = student_hash[:git_hub]
    @blog = student_hash[:blog]
    @profile_quote = student_hash[:profile_quote]
    @bio = student_hash[:bio]
    @profile_url = student_hash[:profile_url]

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    @name = attributes_hash[:name]
    @location = attributes_hash[:location]
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:git_hub]
    @blog = attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio]
    @profile_url = attributes_hash[:profile_url]
  end

  def self.all
    @@all
  end
end
