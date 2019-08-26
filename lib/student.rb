class Student
#=================properties===================
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 
  @@all = []
#=================intialize====================
  def initialize(hash)
    hash.each{|att,value| self.send(("#{att}="), value)}
    @@all << self
  end
#==================class=======================
  def self.all
    @@all
  end
  
  def self.create_from_collection(arr)
    arr.each{|hash| Student.new(hash)}
  end
#=================instance=====================
  def add_student_attributes(hash)
    hash.each do |att,value|
      self.send( ("#{att}="), value) 
    end
  end
#==============================================  
end

