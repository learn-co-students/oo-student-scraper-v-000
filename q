
[1mFrom:[0m /home/travywill/oo-student-scraper-v-000/lib/scraper.rb @ line 14 Scraper.scrape_index_page:

     [1;34m7[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url) [1;34m# def self.scrape_index_page(http://67.205.188.72:46715/fixtures/student-site/)[0m
     [1;34m8[0m:   index_page_array = []
     [1;34m9[0m: 
    [1;34m10[0m:   html = open(index_url) [1;34m# html = open(http://67.205.188.72:46715/fixtures/student-site/)[0m
    [1;34m11[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m12[0m: 
    [1;34m13[0m:   doc.css([31m[1;31m"[0m[31m.student-card[1;31m"[0m[31m[0m).each [32mdo[0m |student_profile|
 => [1;34m14[0m:     binding.pry
    [1;34m15[0m:     student_link = student_profile.attributes[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].value
    [1;34m16[0m:     [1;34m#binding.pry[0m
    [1;34m17[0m:     [1;34m#student_profile.each do |item|[0m
    [1;34m18[0m:     [1;34m#end[0m
    [1;34m19[0m:   [32mend[0m
    [1;34m20[0m:   [1;34m#student_profile.attributes["href"].value[0m
    [1;34m21[0m:   [1;34m#doc.css(".roster")[0m
    [1;34m22[0m:   [1;34m#doc.css(".roster").first[0m
    [1;34m23[0m:   [1;34m#doc.css(".roster-cards-container").first[0m
    [1;34m24[0m:   [1;34m#doc.css(".roster-cards-container").first.css(0xb68d48)[0m
    [1;34m25[0m:   [1;34m#doc.css(".student-card")[0m
    [1;34m26[0m:   [1;34m#doc.css(".card-text-container").first.css("h4").text = Student's name[0m
    [1;34m27[0m:   [1;34m#doc.css(".card-text-container").first.css("p").text = Student's location[0m
    [1;34m28[0m:   [1;34m#doc.css(".student-card").first.css("href")[0m
    [1;34m29[0m:   [1;34m#binding.pry[0m
    [1;34m30[0m: [32mend[0m

