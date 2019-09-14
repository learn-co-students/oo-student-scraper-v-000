class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

#popcorn = Scraper.scrape_index_page("./fixtures/student-site/index.html")
#butter = Scraper.scrape_profile_page(profile_url)
# the method below creates a new student for each student scraped off the index page
  def self.create_from_collection(return_value_of_scrape_index)
    return_value_of_scrape_index.each do |hashie|
      Student.new(hashie)
    end
  end


# the method below add additional info like github link, to each student, from what was scraped off their profile page
  def add_student_attributes(return_value_of_scraped_student_pages)
    return_value_of_scraped_student_pages.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
