class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    @@all << self
=begin
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
=end
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      case k
        when :twitter
          self.twitter = v
        when :linkedin
          self.linkedin = v
        when :github
          self.github = v
        when :blog
          self.blog = v
        when :profile_quote
          self.profile_quote = v
        when :bio
          self.bio = v
        when :profile_url
          self.profile_url = v
      end

    end

  end

  def self.all
    @@all
  end

end
