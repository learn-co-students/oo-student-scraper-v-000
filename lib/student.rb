class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(student_index_array)
    student_index_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(student_hash)
    student_hash.each do |key, value|
      send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end
