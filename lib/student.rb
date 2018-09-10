class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    add_attributes(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.collect { |hash| self.new(hash) }
  end

  def add_student_attributes(attributes_hash)
    add_attributes(attributes_hash)
  end

  def self.all
    @@all
  end
  
  private
  
    def add_attributes(hash)
      hash.each { |k,v| self.send("#{k}=" ,v) }
    end

end

