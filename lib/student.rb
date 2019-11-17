'require pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

    @@all = []

  def initialize(student_hash)
    student_hash.each do |k, v|
      self.send(("#{k}="), v)
    end
    @@all << self
   end



  def self.create_from_collection(student_index_array)

    student_index_array.each do |student|
      new_student = self.new(student)
    end
   end


  def add_student_attributes(student_profile)
    
      student_profile.each do |k,v|
        self.send(("#{k}="), v)
      end
      self
  end

  def self.all
    @@all
  end
end
