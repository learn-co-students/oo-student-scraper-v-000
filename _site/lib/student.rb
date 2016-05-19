class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each{|key,value| 
        if key == :name
          self.name = value
        elsif key == :location
          self.location = value
        elsif key == :twitter
          self.twitter = value
        elsif key == :linkedin
          self.linkedin = value
        elsif key == :github
          self.github = value
        elsif key == :blog
          self.blog = value
        elsif key == :profile_quote
          self.profile_quote = value
        elsif key == :bio
          self.bio = value
        elsif key == :profile_url
          self.profile_url = value                   
        end}
    @@all << self
  end

  def self.create_from_collection(students_array)
  
      
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|key,value| 
        if key == :name
          self.name = value
        elsif key == :location
          self.location = value
        elsif key == :twitter
          self.twitter = value
        elsif key == :linkedin
          self.linkedin = value
        elsif key == :github
          self.github = value
        elsif key == :blog
          self.blog = value
        elsif key == :profile_quote
          self.profile_quote = value
        elsif key == :bio
          self.bio = value
        elsif key == :profile_url
          self.profile_url = value
        end}

    self   
  end

  def self.all
    @@all
  end
end

