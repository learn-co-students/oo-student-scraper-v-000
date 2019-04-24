class Student

      attr_accessor :name, :location, :profile_url, :profile_quote, :bio, :twitter, :linkedin, :github, :blog

      @@all = []

      def initialize(student_hash)
        student_hash.each { |key, value| send("#{key}=", value) }
        @@all << self
      end

      def self.create_from_collection(students_array)
        students_array.each do |student|
          student_hash= student
          self.new(student_hash)
        end
      end

      def add_student_attributes(attributes_hash)
        attributes_hash.each { |key, value| send("#{key}=", value) }
        @@all << self
        self
      end

      def self.all
        @@all
      end


end
