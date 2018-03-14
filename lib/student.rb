class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #metaprogramming, use #send method! #add to @@all =[]
    self.add_student_attributes(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    #array of hashes #iterate over hash from scrape_index_page to create new student
      students_array.each do |student_hash|
          x = self.new(student_hash)
      end
  end

  def add_student_attributes(attributes_hash)
    #return the student, self
    #use meta-rpogramming to assign values and keys!
    attributes_hash.each do |key, value|
        self.send(("#{key}="), value)
    end
    return self
  end

  def self.all
    @@all
  end
end
