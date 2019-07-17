class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def self.all
    @@all
  end

  def initialize(student_hash)
    # use metaprogramming - assign newly created attributes and values
    # use SEND method

    student = Student.new(student_hash)

    student_hash.each do |hash_attribute_key, value|
      student.send("#{hash_attribute_key}=", value)
    end

#    student      <---uncomment this to have initialized student data to be returned

#    student.save      <----create save method that shovels student to Student.all
  end

  def self.create_from_collection(students_array)
    # iterate over STUDENTS_ARRAY of hashes
    # create a new individual student using each hash

    students_array.each do ||

    end

    Student.all.each do |each_student|
      @@all << each_student
    end

  end

  def add_student_attributes(attributes_hash)

  end


end
