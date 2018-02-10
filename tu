
[1mFrom:[0m /home/keith-94593/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 22 Scraper.scrape_index_page:

     [1;34m7[0m:   [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m8[0m:     html = open(index_url)
     [1;34m9[0m:     doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m10[0m:     students = {}
    [1;34m11[0m:     roster = []
    [1;34m12[0m: 
    [1;34m13[0m:     doc.css([31m[1;31m"[0m[31m.roster-cards-container .student-card a[1;31m"[0m[31m[0m).each [32mdo[0m |student|
    [1;34m14[0m:       student_info = student.css([31m[1;31m"[0m[31m.card-text-container[1;31m"[0m[31m[0m).text.gsub([31m[1;31m'[0m[31m\n[1;31m'[0m[31m[0m, [31m[1;31m'[0m[31m[1;31m'[0m[31m[0m)
    [1;34m15[0m:       students = {}
    [1;34m16[0m:       students[student_info.to_sym] = {
    [1;34m17[0m:         [33m:name[0m => student.css([31m[1;31m"[0m[31m.student-name[1;31m"[0m[31m[0m).text,
    [1;34m18[0m:         [33m:location[0m => student.css([31m[1;31m"[0m[31m.student-location[1;31m"[0m[31m[0m).text
    [1;34m19[0m: 
    [1;34m20[0m:       }
    [1;34m21[0m:       roster << students
 => [1;34m22[0m: binding.pry
    [1;34m23[0m: 
    [1;34m24[0m:     [32mend[0m
    [1;34m25[0m: 
    [1;34m26[0m: 
    [1;34m27[0m: 
    [1;34m28[0m:     roster
    [1;34m29[0m: 
    [1;34m30[0m:   [32mend[0m

