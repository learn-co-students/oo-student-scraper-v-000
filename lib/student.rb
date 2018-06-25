class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

    def initialize(student_hash)
      @name = student_hash[:name]
      @location = student_hash[:location]
      @@all << self
    end


    def self.create_from_collection(students_array)

    # iterate over each of the students_array create_from_collection
      students_array.each do |student|
      #we want it to create a new student. & passed in each individual student
      Student.new(student)  # called it.
    end
    end

    def add_student_attributes(attributes_hash)
    #iterating over an hash... keep  track of keys and value..
    # Do something with the key and value}
    attributes_hash.each {|key, value| self.send(("#{key}="), value)} #example in the Mass Assignment and Metaprogramming

    end


    def self.all
      @@all
    end
end
