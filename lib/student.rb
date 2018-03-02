class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k,v|
      self.send("#{k}=", v)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
      @@all << self 
    end
  end

  def add_student_attributes(attributes_hash)
    @bio = attributes_hash[:bio]
    @blog = attributes_hash[:blog]
    @linkedin = attributes_hash[:linkedin]
    @profile_quote = attributes_hash[:profile_quote]
    @twitter = attributes_hash[:twitter]
  end

  def self.all
    @@all
  end
end

