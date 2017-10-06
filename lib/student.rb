class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash.values_at(:name).join
    @location = student_hash.values_at(:location).join
    @profile_url = student_hash.values_at(:profile_url).join
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
    new_student = self.new(student)
    new_student
   end
  end

  def add_student_attributes(attributes_hash)
   @twitter = attributes_hash.values_at(:twitter).join
   @linkedin = attributes_hash.values_at(:linkedin).join
   @github = attributes_hash.values_at(:github).join
   @blog = attributes_hash.values_at(:blog).join
   @profile_quote = attributes_hash.values_at(:profile_quote).join
   @bio = attributes_hash.values_at(:bio).join
  end

  def self.all
   @@all
  end
end
