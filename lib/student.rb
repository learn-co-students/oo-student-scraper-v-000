class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  # def name=(name)
  #   @name = name
  #   # binding.pry
  # end

  # def name
  #   @name
  # end

  # use meta-programming(#send) to assign the newly created student attributes and values per
  # the key/value pairs of the hash
  # Student #new takes in an argument of a hash and sets that new student's attributes
  # using the key/value pairs of that hash.
  def initialize(student_hash)
    @student_hash = student_hash
    @name = @student_hash[:name]
    @location = @student_hash[:location]

    # @student_hash.send(:name)
    # binding.pry
    @@all << self
  end

  # The
  # `#create_from_collection` method should iterate over the array of hashes and
  # create a new individual student using each hash. This brings us to the
  # `#initialize` method on our `Student` class.

  def self.create_from_collection(students_array)
    students_array.each do |student|
      student = Student.new(@student_hash)
    end
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
