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
		Student.new(student)
    end
  end


  def add_student_attributes(attributes_hash)
	attributes_hash.each do |attr|
		if attr.include?(:twitter)
			@twitter = attr[1]
		elsif attr.include?(:linkedin)
			@linkedin = attr[1]
		elsif attr.include?(:github)
			@github = attr[1]
		elsif attr.include?(:blog)
			@blog = attr[1]
		elsif attr.include?(:profile_quote)
			@profile_quote = attr[1]
		elsif attr.include?(:bio)
			@bio = attr[1]
		elsif attr.include?(:profile_url)
			@profile_url = attr[1]
		end
	end
	self
  end

  def self.all
    @@all
  end
end

