class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(student_index_array)
    student_index_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(student_hash)
    student_hash.each do |title, link|
      self.send(("#{title}="), link)
    end
  end

  def self.all
    @@all
  end
end

