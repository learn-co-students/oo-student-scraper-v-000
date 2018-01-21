class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
      #attr_accessors are set for each of the keys in the hashes from Scraper class
  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|       #iterate over the student hash
      self.send("#{key}=", value)           #send the student's keys the corresponding values
    end                                     #end iteration
    @@all << self                           #push the student into the all array
  end                                       #end method

  def self.create_from_collection(students_array)
    students_array.each {|hash| Student.new(hash)}  #iterate over the students_array and create new Students from the hash
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|       #iterate over attributes_hash
      self.send("#{key}=", value)              #send the student's keys the corresponding values
    end                                        #end iteration
    self                                       #return the student
  end                                          #end method

  def self.all
    @@all                                       #return the @@all array
  end                                           #end method
end                                             #end class
