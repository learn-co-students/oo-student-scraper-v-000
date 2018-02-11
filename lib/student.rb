class Student
   attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

   @@all = []

   def initialize(student_hash)
      student_hash.each do |key, value|
         send("#{key}=", value)
      end
      @@all.push(self)
   end

   def self.create_from_collection(students_array)
      students_array.each do |student|
         student_from_collection = Student.new(student)
      end
   end

   def add_student_attributes(attributes_hash)
      attributes_hash.each do|key, value|
            send("#{key}=", value)
      end
   end

   def self.all
      @@all
   end
end
