class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.map{|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end

# Scraper.scrape_index_page(index_url)
# # => [
# {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
# {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
# {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"},
# {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "./fixtures/student-site/students/lorenzo-oro.html"},
# {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "./fixtures/student-site/students/marisa-royer.html"}
# ]

# Scraper.scrape_profile_page(profile_url)
# # => {:twitter=>"http://twitter.com/flatironschool",
#       :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio=> "I'm a school"
#      }
