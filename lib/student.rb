class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

#these methods shouldn't be dependent on scraper class, just be able to take in any info
  def initialize(student_hash)
      student_hash.each {|key, value| self.send(("#{key}="), value)}
      #much quicker than defining each individually

      @@all << self
  end

  def self.create_from_collection(students_array)
      students_array.each do |student|
        student = Student.new(student)
      end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
    #here you're not creating new students, youre adding new attributes to students you created above
    self
  end

  def self.all
    @@all
  end

end
