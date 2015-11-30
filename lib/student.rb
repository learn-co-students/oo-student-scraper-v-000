class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    # self.name = student_hash.values_at(:name).join(" ")
    # self.location = student_hash.values_at(:location).join(" ")
    # self.profile_url = student_hash.values_at(:profile_url).join(" ")
    @@all <<  self
  end

  def self.create_from_collection(students_array) # array of hashes
    # create a new individual student from each hash
    students_array.each {|student| puts student}
  end

  def add_student_attributes(attributes_hash)

    attributes_hash.each do 
      attributes_hash.each {|key, value| self.send(("#{key}="), value)}
    end
  end

  def self.all
    @@all
  end
end

