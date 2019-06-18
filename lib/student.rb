class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @twitter = student_hash[:twitter]
    @linkedin = student_hash[:linkedin]
    @github = student_hash[:github]
    @blog = student_hash[:blog]
    @profile_quote = student_hash[:profile_quote]
    @bio = student_hash[:bio]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      new_student = {}
      new_student[:name] = student[:name]
      new_student[:location] = student[:location]
      self.new(new_student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute|
      if attribute[0] == :twitter
        self.twitter = attribute[1]
      elsif attribute[0] == :linkedin
        self.linkedin = attribute[1]
      elsif attribute[0] == :github
        self.github = attribute[1]
      elsif attribute[0] == :blog
        self.blog = attribute[1]
      elsif attribute[0] == :profile_quote
        self.profile_quote = attribute[1]
      elsif attribute[0] == :bio
        self.bio = attribute[1]
      elsif attribute[0] == :profile_url
        self.profile_url = attribute[1]
      end
    end
  end

  def self.all
    @@all
  end
end
