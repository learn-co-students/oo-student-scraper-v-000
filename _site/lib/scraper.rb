class Scraper

  def scrape_index_page
    index = open(index_url)
    names = []
    locations = []
    scraped_students = []
    doc = Nokogiri::HTML(index)
    student_data = doc.css(".student-card")

    student_data.each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    scraped_students
  end














end
