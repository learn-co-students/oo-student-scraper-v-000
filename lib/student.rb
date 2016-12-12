class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      @match = 0
      name = student[:name]
      location = student[:location]
        @@all.each do |student_in_all|
          if student_in_all.name == name
          @match = 1
          end
        end
      if @match == 0
        student = Student.new(student)
      end
    end
  end

  def add_student_attributes(attributes_hash)
    @@all.each do |student|
      if student.name == self.name #identify/load the student into 'student' variable
        if attributes_hash[:twitter] != nil
          student.twitter = attributes_hash[:twitter]
        end

        if attributes_hash[:linkedin] != nil
          student.linkedin = attributes_hash[:linkedin]
        end

        if attributes_hash[:github] != nil
          student.github = attributes_hash[:github]
        end

        if attributes_hash[:blog] != nil
          student.blog = attributes_hash[:blog]
        end

        if attributes_hash[:profile_quote] != nil
          student.profile_quote = attributes_hash[:profile_quote]
        end

        if attributes_hash[:bio] != nil
          student.bio = attributes_hash[:bio]
        end
      end
    end
  end

  def self.all
    @@all
  end
end
