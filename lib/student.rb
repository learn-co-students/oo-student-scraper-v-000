require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    
   
    student_hash.each do |key,val|
      
      if key == :name
        @name = val
      elsif key == :location
        @location = val
      elsif key == :twitter
        @twitter = val
      elsif key == :linkedin
        @linkedin = val 
      elsif key == :github
        @github = val 
      elsif key == :blog
        @blog = val         
      elsif key == :profile_quote
        @profile_quote = val          
      elsif key == :bio
        @bio = val           
      elsif key == :profile_url
        @profile_url = val                   
      end

    end
    
    @@all << self
        
  end

  def self.create_from_collection(students_array)
           
      students_array.each do |students|
        puts "#{students}"
        student = Student.new(students_array)
        students.each do |key,val|

          if key == :name
            puts "name #{val}"
            student.name = val
            
          elsif key == :location
            student.location = val
            @@all << student
          end          
        end
      end
    end
    

    
    
  

  def add_student_attributes(attributes_hash)
    
    attributes_hash.collect do |key, val|      
      if key == :name
        @name = val
      elsif key == :location
        @location = val
      elsif key == :twitter
        @twitter = val
      elsif key == :linkedin
        @linkedin = val 
      elsif key == :github
        @github = val 
      elsif key == :blog
        @blog = val         
      elsif key == :profile_quote
        @profile_quote = val          
      elsif key == :bio
        @bio = val           
      elsif key == :profile_url
        @profile_url = val                   
      end

    end

    


  end

  def self.all
    @@all
    
  end
end

