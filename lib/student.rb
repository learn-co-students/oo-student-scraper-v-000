class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student = student_hash
    @name = student[:name]
    @location = student[:location]
    @profile_url = student[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |stud|
      Student.new(stud)
    end
  end

  def add_student_attributes(attributes_hash)
    stu_att = attributes_hash
    @twitter = stu_att[:twitter]
    @linkedin = stu_att[:linkedin]
    @github = stu_att[:github]
    @blog = stu_att[:blog]
    @profile_quote = stu_att[:profile_quote]
    @bio = stu_att[:bio]
  end

  def self.all
    @@all
  end
end
