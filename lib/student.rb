class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]

    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    self.tap do |student_attr|
      student_attr.bio = attributes_hash[:bio]
      student_attr.blog = attributes_hash[:blog]
      student_attr.profile_quote = attributes_hash[:profile_quote]
      student_attr.linkedin = attributes_hash[:linkedin]
      student_attr.twitter = attributes_hash[:twitter]
      student_attr.github = attributes_hash[:github]
    end
  end

  def self.all
    @@all
  end
end
