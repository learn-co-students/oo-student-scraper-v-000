class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # s = Student.new(student_hash)
    # s.name = student_hash[:name]
    # s.location = student_hash[:location]
    # s.twitter = student_hash[:twitter]
    # s.linkedin = student_hash[:linkedin]
    # s.github = student_hash[:github]
    # s.blog = student_hash[:blog]
    # s.quote = student_hash[:quote]
    # s.bio = student_hash[:bio]
    # s.profile_url = student_hash[:profile_url]
    #
    # @@aall << s

  end

  def self.create_from_collection(students)
      s = Student.new(students)

      s = students.collect do |student|
        s.name=student[:name]
        s.location=student[:location]
        s
        binding.pry
        @@all << s
      end
    end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end
