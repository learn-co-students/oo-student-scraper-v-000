class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}

    # @name= student_hash[:name]
    # @location= student_hash[:location]
    #@proile_url= profile_url

    @@all << self
  #  binding.pry
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}

    # attributes_hash.each do |attribute|
    #   @twitter= twitter
    #   @linkedin= linkedin
    #   @github= github
    #   @blog= blog
    #   @profile_quote= profile_quote
    #   @bio= bio
    # end
    self

  end

  def self.all
    @@all
  end
end
