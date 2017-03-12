
require "nokogiri"
def self.scrape_index_page(index_url)

     @index_url
     html = File.read('fixtures/student-site/')
     student_scraper = Nokogiri::HTML(html)

     #Nokogiri::HTML(open("http://138.68.63.182:30016/fixtures/student-site/"))

 scraped_students = {}
 doc.map do |node|

   scraped_students = {
     hash['link'] = node.css('cards.collect{|node| node.css('a').first['href'] }')
     hash['name'] = node.css('students.collect { |node| node.css('.student-name').text }')
     hash['location'] = node.css('students.collect { |node| node.css('.student-location').text }')
   }
 end
 scraped_students
end
