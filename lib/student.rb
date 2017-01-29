class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    add_student_attributes(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    @name = attributes_hash[:name] if attributes_hash[:name]
    @location = attributes_hash[:location] if attributes_hash[:location]
    @twitter = attributes_hash[:twitter] if attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin] if attributes_hash[:linkedin]
    @github = attributes_hash[:github] if attributes_hash[:github]
    @blog = attributes_hash[:blog] if attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote] if attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio] if attributes_hash[:bio]
    @profile_url = attributes_hash[:profile_url] if attributes_hash[:profile_url]
  end

  def self.all
    @@all
  end
end
