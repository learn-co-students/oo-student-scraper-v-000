class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @student_hash = student_hash

    # binding.pry
  end

  # The
  # `#create_from_collection` method should iterate over the array of hashes and
  # create a new individual student using each hash. This brings us to the
  # `#initialize` method on our `Student` class.

  def self.create_from_collection(students_array)
    # students_array.each do |student|
    #   student[:name] = @name
    # end
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
