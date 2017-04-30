class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # {:name => "Sophie DeBenedetto", :location => "Brooklyn, NY"}

    # it "takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash." do 
    #   expect{Student.new({:name => "Sophie DeBenedetto", :location => "Brooklyn, NY"})}.to_not raise_error
    #   expect(student.name).to eq("Alex Patriquin")
    #   expect(student.location).to eq("New York, NY")
    # end 
    @name = student_hash[:name] 
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    # it "adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable." do 
    #   expect(Student.class_variable_get(:@@all).first.name).to eq("Alex Patriquin")
    # end
    @@all << self
  end

  def self.create_from_collection(students_array)
    # students_array = [
      # {:name=>"Alex Patriquin", :location=>"New York, NY"},
      # {:name=>"Bacon McRib", :location=>"Kansas City, MO"},
      # {:name=>"Alisha McWilliams", :location=>"San Francisco, CA"},
      # {:name=>"Daniel Fenjves", :location=>"Austin, TX"},
      # {:name=>"Arielle Sullivan", :location=>"Chicago, IL"},
      # {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"},
      # {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}
    # ]
      students_array.each do |student_hash|
        Student.new(student_hash)
      end 

  end

  def add_student_attributes(attributes_hash)
      # it "uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student." do 
      # attributes_hash = {
      #   :twitter=>"someone@twitter.com",
      #   :linkedin=>"someone@linkedin.com",
      #   :github=>"someone@github.com",
      #   :blog=>"someone@blog.com",
      #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      #   :bio=> "I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school."
      # }
      # attributes_hash.each do |attribute|
      #   attribute[:twitter]
      #   attribute[:linkedin]
      # end 
      @twitter = attributes_hash[:twitter] 
      @linkedin = attributes_hash[:linkedin] 
      @github = attributes_hash[:github] 
      @blog = attributes_hash[:blog]
      @profile_quote = attributes_hash[:profile_quote] 
      @bio = attributes_hash[:bio] 
      # self.linkedin = attributes_hash[:linkedin] 
      # student.add_student_attributes(student_hash) 
      # expect(student.bio).to eq("I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school.")
      # expect(student.blog).to eq("someone@blog.com")
      # expect(student.linkedin).to eq("someone@linkedin.com")
      # expect(student.profile_quote).to eq("\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi")
      # expect(student.twitter).to eq("someone@twitter.com")
    #end

  end

  def self.all
    @@all
  end
end

