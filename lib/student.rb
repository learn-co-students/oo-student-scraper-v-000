class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    sh = student_hash
    @name = sh[:name]
    @location = sh[:location]
    @twitter = sh[:twitter]
    @linkedin = sh[:linkedin]
    @github = sh[:github]
    @blog = sh[:blog]
    @profile_quote = sh[:profile_quote]
    @bio = sh[:bio]
    @profile_url = sh[:profile_url] 
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each { |student|  Student.new(student) }
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |x|
      if x[0] == :twitter
        self.twitter = x[1]
      elsif x[0] == :linkedin
        self.linkedin = x[1]
      elsif x[0] == :github
        self.github = x[1]
      elsif x[0] == :blog
        self.blog = x[1]
      elsif x[0] == :profile_quote
        self.profile_quote = x[1]
      elsif x[0] == :bio
        self.bio = x[1]
      elsif x[0] == :profile_url
        self.profile_url = x[1]
      end
    end
  end

  def self.all
    @@all 
  end
end

