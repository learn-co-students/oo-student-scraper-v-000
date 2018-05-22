class Student
	attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  	@@all = []

  	def initialize(student_hash)
		self.name.nil?
			self.name = student_hash[:name]
		self.location.nil?
			self.location = student_hash[:location]
		self.save
  	end

  	def self.create_from_collection(students_array)
	  	students_array.each {|student| student = Student.new(student)}
  	end

  	def add_student_attributes(attributes_hash)
		student_attributes = attributes_hash.each_key do |key|
			self.send("#{key}=", attributes_hash[key])
		end
		student = Student.new(student_attributes)
		self
  	end

  	def self.all
    	@@all
  	end

  	def save
	  	@@all << self
  	end
end
