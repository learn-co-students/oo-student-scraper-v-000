class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def name=(name)
    @name = @student_hash[:name]
  end

  def location=(location)
    @location = @student_hash[:location]
  end

  # use meta-programming(#send) to assign the newly created student attributes and values per
  # the key/value pairs of the hash
  # Student #new takes in an argument of a hash and sets that new student's attributes
  # using the key/value pairs of that hash.
  def initialize(student_hash)
    @student_hash = student_hash
    # @name = @student_hash[:name]    "This works but doesn't use send as required by lab"
    # @location = @student_hash[:location]    "This works but doesn't use send as required by lab"
    send(:name=, name)
    send(:location=, location)
    # @student_hash.send(:name=, name)    "This didn't work with @student_hash in the beginning of the send method"
    # @student_hash.send(:location=, location)    "This didn't work with @student_hash in the beginning of the send method"
    @@all.push(self)
    # binding.pry
  end

  # The `#create_from_collection` method should iterate over the array of hashes and
  # create a new individual student using each hash. This brings us to the
  # `#initialize` method on our `Student` class.

  def self.create_from_collection(students_array)
    # binding.pry
    students_array.each do |student|
      # binding.pry
      Student.new(student)
    end
  end

  # Student #add_student_attributes uses the Scraper class to get a hash of a given
  # students attributes and uses that hash to set additional attributes

  def add_student_attributes(attributes_hash)
    # binding.pry
    attributes_hash.each do |attribute|
      binding.pry
      attributes_hash[:attribute]
      self
    end
  end

  def self.all
    @@all
  end

end
