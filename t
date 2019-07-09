
[1mFrom:[0m /home/MNGiit/oo-student-scraper-v-000/lib/scraper.rb @ line 30 Scraper.scrape_index_page:

     [1;34m6[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m7[0m:   [1;34m#array_hashes student => student_info[0m
     [1;34m8[0m:   [1;34m# {:name => "Abby Smith", :location}[0m
     [1;34m9[0m:   students = []
    [1;34m10[0m: 
    [1;34m11[0m:   html = [1;34;4mFile[0m.read([31m[1;31m'[0m[31m./fixtures/student-site/index.html[1;31m'[0m[31m[0m)    
    [1;34m12[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m13[0m: 
    [1;34m14[0m:   [1;34m#item = doc.css("roster-cards-container") #doesn't work[0m
    [1;34m15[0m:   items = doc.css([31m[1;31m"[0m[31mdiv.roster-cards-container[1;31m"[0m[31m[0m)
    [1;34m16[0m:   
    [1;34m17[0m:   cards = items.css([31m[1;31m"[0m[31mdiv.student-card[1;31m"[0m[31m[0m)
    [1;34m18[0m:   [1;34m#cards = items.css(".student-card")[0m
    [1;34m19[0m:   
    [1;34m20[0m:   [1;34m#student_name = cards[0].css(".student-name").text #this works, now do it for all of them[0m
    [1;34m21[0m:   
    [1;34m22[0m:   cards.each [32mdo[0m |card|
    [1;34m23[0m:     card_name = card.css([31m[1;31m"[0m[31m.student-name[1;31m"[0m[31m[0m).text
    [1;34m24[0m:     card_location = card.css([31m[1;31m"[0m[31m.student-location[1;31m"[0m[31m[0m).text
    [1;34m25[0m:     card_url = card.css([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m).text
    [1;34m26[0m:     students << {[35mname[0m: card_name, [35mlocation[0m: card_location, [35mprofile_url[0m: card_url}
    [1;34m27[0m:   [32mend[0m
    [1;34m28[0m:   
    [1;34m29[0m:   students
 => [1;34m30[0m:   binding.pry
    [1;34m31[0m: [32mend[0m

