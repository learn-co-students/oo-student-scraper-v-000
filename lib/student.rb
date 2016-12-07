class Student

  attr_accessor :name, :location, :profile_quote, :bio, :profile_url, :twitter, :linkedin, :github, :blog

  @@all = []

  def initialize(student_info)

    @name = student_info[:name]
    @location = student_info[:location]
    @profile_url = student_info[:profile_url]
    @@all << self

  end

  def self.create_from_collection(student_array)

    student_array.each do |student|
      student = self.new(student)
    end

  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |student, name|
      self.send(("#{student}="), name)
    end
  end

  def self.all
    @@all
  end
end
