class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # use metaprogramming - assign newly created attributes and values
    # use SEND method

  end

  def self.create_from_collection(students_array)
    # iterate over STUDENTS_ARRAY of hashes
    # create a new individual student using each hash
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
