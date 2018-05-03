class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.send("name=", student_hash[:name])
    self.send("location=", student_hash[:location])
    self.send("twitter=", student_hash[:twitter])
    self.send("linkedin=", student_hash[:linkedin])
    self.send("github=", student_hash[:github])
    self.send("blog=", student_hash[:blog])
    self.send("profile_quote=", student_hash[:profile_quote])
    self.send("bio=", student_hash[:bio])
    self.send("profile_url=", student_hash[:profile_url])

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{|hash| new(hash)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send("#{k}=", "#{v}")
    end
    self
  end

  def self.all
    @@all
  end
end
