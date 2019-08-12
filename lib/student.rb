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
    student_hash.each do |k, v|
      instance_variable_set(:"@#{k}", v)
    end
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