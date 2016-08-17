class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash=nil)
      if student_hash
        student_hash.each do |k,v|
          self.send("#{k}=", v)
        end
        @@all << self
      end
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash=nil)
    if attributes_hash
      attributes_hash.each do |k,v|
        self.send("#{k}=", v)
      end
    end
    self
  end

  def self.all
    @@all
  end
end
