class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.keys.each do |key|
        m = "#{key}="
        self.send( m, hash[key] ) if self.respond_to?( m )
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    
    students_array.each {|student| @@all << Self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self[key] = value }
  end

  def self.all
    @@all
  end
end

