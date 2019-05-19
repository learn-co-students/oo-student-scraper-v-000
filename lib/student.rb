require 'pry'

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

    student_hash.each do |k,v|
      self.send("#{k}=", v)
    end

    @@all << self
  end

  def self.create_from_collection(students_array)
   #  "./fixtures/student-site/students/joe-burgess.html"

    students_array.each do |student_hash|
      # adjusted_name = student_hash[:name].downcase.gsub(' ','-')
      # student_profile_url = "./fixtures/student-site/students/#{adjusted_name}.html"

      # new_student_hash = Scraper.scrape_profile_page(student_profile_url)

      self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send("#{k}=",v)
    end
    self
  end

  def self.all
    @@all
  end
end

