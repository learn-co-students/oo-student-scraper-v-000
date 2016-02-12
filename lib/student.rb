class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each { |student| self.new(student) }
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |key, value| self.send key, value}
    self
  end

  def self.all
    @@all
  end

  def twitter(link = nil)
    link ? @twitter = link : @twitter
  end

  def linkedin(link = nil)
    link ? @linkedin = link : @linkedin
  end

  def github(link)
    @github = link
  end

  def blog(link = nil)
    link ? @blog = link : @blog
  end

  def profile_quote(link = nil)
    link ? @profile_quote = link : @profile_quote
  end

  def bio(link = nil)
    link ? @bio = link : @bio
  end
end
