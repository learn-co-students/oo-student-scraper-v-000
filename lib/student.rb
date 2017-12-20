class Student
  attr_accessor :name, :location, :profile_url, :bio, :twitter, :linkedin, :github, :blog, :profile_quote

  @@all = []

  def initialize(student_hash={})
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.map do |student_hash|
      self.new(student_hash)
    end
  end

  def add_student_attributes(student_hash)
    @twitter = student_hash[:twitter]
    @linkedin = student_hash[:linkedin]
    @github = student_hash[:github]
    @blog = student_hash[:blog]
    @profile_quote = student_hash[:profile_quote]
    @bio = student_hash[:bio]  
  end

  def self.all
    @@all
  end

  def index_hash
    {
      name: self.name,
      location: self.location,
      profile_url: self.profile_url,
    }
  end

  def profile_hash
    {
      bio: self.bio,
      twitter: self.twitter,
      linkedin: self.linkedin,
      github: self.github,
      blog: self.blog,
      profile_quote: self.profile_quote
    }
  end

end