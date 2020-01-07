
[1mFrom:[0m /home/malbazaz/oo-student-scraper-v-000/lib/scraper.rb @ line 23 Scraper.scrape_index_page:

     [1;34m7[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m8[0m:   index_page = [1;34;4mNokogiri[0m::HTML(open([31m[1;31m"[0m[31m./fixtures/student-site/index.html[1;31m"[0m[31m[0m))
     [1;34m9[0m: 
    [1;34m10[0m:    [1;34m#name = index_page.css(".student-card h4.student-name").first.text[0m
    [1;34m11[0m:   [1;34m#location = index_page.css(".student-card p.student-location").first.text[0m
    [1;34m12[0m:   [1;34m#profile_url = index_page.css(".student-card a").attribute("href").value[0m
    [1;34m13[0m:  
    [1;34m14[0m:   students = {}
    [1;34m15[0m:   index_page.css([31m[1;31m"[0m[31m.roster-cards-container .student-card[1;31m"[0m[31m[0m).each [32mdo[0m |student|
    [1;34m16[0m:     name_title = student.css([31m[1;31m"[0m[31mh4[1;31m"[0m[31m[0m).text
    [1;34m17[0m:    [1;34m# binding.pry [0m
    [1;34m18[0m:     students[name_title.to_sym] = {
    [1;34m19[0m:       [33m:name[0m => student.css([31m[1;31m"[0m[31mh4[1;31m"[0m[31m[0m).text,
    [1;34m20[0m:       [33m:location[0m => student.css([31m[1;31m"[0m[31mp[1;31m"[0m[31m[0m).text,
    [1;34m21[0m:       [33m:profile_url[0m => student.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
    [1;34m22[0m:     }
 => [1;34m23[0m:   binding.pry 
    [1;34m24[0m:   [32mend[0m
    [1;34m25[0m:   
    [1;34m26[0m:     students 
    [1;34m27[0m:   [1;34m#binding.pry [0m
    [1;34m28[0m: 
    [1;34m29[0m: [32mend[0m

