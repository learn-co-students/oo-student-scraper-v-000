class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    student_hash.map do |key|
      key[0] = self.name
      key[1] = self.location
    @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.map do |new_student|
      # binding.pry
      @name = new_student[:name]  #<- returns "Alex Patriquin"
      # new_student[:name] == name
      self.new(name)
    end
    @@all << self
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end
