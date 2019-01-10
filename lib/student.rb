class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # mass assign attributes from hash
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    # save new Student instances to @@all array
    @@all << self
  end

  def self.create_from_collection(students_array)
    # iterate through students array and instance Students
    students_array.each do |hsh|
      self.new(hsh)
    end
  end

  def add_student_attributes(attributes_hash)
    # allow Student object to iterate over a hash of new attributes
      attributes_hash.each do |key, value|
        self.send("#{key}=", value)
      end
  end

  def self.all
    # saving method
    @@all
  end
end
