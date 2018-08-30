class Student

  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(student_array)
    student_array.each do |hash|
      self.new(hash)
    end

  end

  def add_student_attributes(attributes)
    attributes.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    self

  end

  def self.all
    @@all
  end
end
