class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)

  end

  def self.create_from_collection(students_array)
   #  properties = Scraper.new
   #   properties.each do |k,v|
   #     scraper.send("#{k}=", v)
   #   end
   # end
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end
