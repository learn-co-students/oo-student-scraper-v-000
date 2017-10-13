require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index.url))#can be refactored later, "./fixtures/student-site/index.html"
    students = []
    binding.pry
    doc.css("div.roster-cards-container").each do |c|
      c.css(".student-card a").each do |student|
         student_profile = "#{student.attr('href')}"
         student_name = student.css(".student-name").text
         student_location = student.css(".student-location").text
       end
     end
     students
   end
 end
#   def self.scrape_profile_page(profile_url)#./fixtures/student-site/students
#     doc = Nokogiri::HTML(open(profile.url))
  binding.pry
#     profiles = []
#     doc.css(" ").each do |student|
#       student.css
#         student_linkedin =
#         student_github =
#         student_blog =
#         student_profile_quote =
#         student_blog =
# =>    end
      end
      students
    end
# # return :linkedin  :github  :blog  :profile_quote :bio
#
#   end

 # Scraper.new.scrape_index_page

     #".card-text-container"
    # info = {}
    # doc.css(".roster-cards-container").each do |details|
    #   name = details.css("").text
    #     details[name] = {
    #       :location => details.css("").text
          # :profile_url => details.css(" ..... a img").attribute("src").value


  #
  # :name :location, :profile_url
  #   get_students
  #   #/fixtures/student-site/
  # end
  #
  #
  #
  # def get_students
  #   self.get_page.css
  #    # this returns the array
  # end
   #
  #  return array of hashes with
  #  :name :location, :profile_url
   #
  #  return :linkedin  :github  :blog  :profile_quote :bio

    # doc = Nokogiri::HTML(open("index_url"))
#
# end
# def self.scrape_profile_page(profile_url)
#   get_page
