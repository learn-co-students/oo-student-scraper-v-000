class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.send(:name=, student_hash[:name])
    self.send(:location=, student_hash[:location])

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.collect {|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.collect do |attribute,value|
        if attribute == :bio
          self.send(:bio=, value)
        elsif attribute == :blog
          self.send(:blog=, value)
        elsif attribute == :linkedin
          self.send(:linkedin=, value)
        elsif attribute == :profile_quote
          self.send(:profile_quote=, value)
        elsif attribute == :twitter
          self.send(:twitter=, value)
        end
    end
    self
  end

  def self.all
    @@all
  end

end
