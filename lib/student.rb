class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(hash)
    hash.each {|key, value| self.send(("#{key}="), value) }
    @@all << self
  end

  def self.create_from_collection(student_index_array)
    student_index_array.each do |hash|
      Student.new(hash)
    end
  end

  def add_student_attributes(student_info)
    student_info.each {|key, value| self.send(("#{key}="), value) }
    self
  end

  def self.all
    @@all
  end
end
