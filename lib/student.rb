class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)

  end

  def self.create_from_collection(students_array)
    # The keys of the individual student hashes should be :name, :location and :profile_url.
    html = open(students_array)
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
