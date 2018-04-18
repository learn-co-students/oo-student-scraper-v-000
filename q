
[1mFrom:[0m /home/esugano/oo-student-scraper-v-000/lib/scraper.rb @ line 46 Scraper.scrape_profile_page:

    [1;34m25[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m26[0m:   student_profile = {}
    [1;34m27[0m:   html = open(profile_url)
    [1;34m28[0m:   messy_code = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m29[0m:   cleaner_code = messy_code.css([31m[1;31m'[0m[31m.vitals-container[1;31m'[0m[31m[0m)
    [1;34m30[0m:   [1;34m#goes through the first div section to grab social links[0m
    [1;34m31[0m:   cleaner_code.each [32mdo[0m |student|
    [1;34m32[0m:     social = student.css([31m[1;31m'[0m[31m.social-icon-container a[1;31m'[0m[31m[0m).map { |link| link[[31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m] }
    [1;34m33[0m:     student_profile = {[33m:twitter[0m=> social[[1;34m0[0m], [33m:linkedin[0m=> social[[1;34m1[0m], [33m:github[0m=> social[[1;34m2[0m], [33m:blog[0m=> social[[1;34m3[0m]}
    [1;34m34[0m:   [32mend[0m
    [1;34m35[0m: 
    [1;34m36[0m:  [1;34m#goes through the second div section to grab the quote[0m
    [1;34m37[0m:   cleaner_code.each [32mdo[0m |student|
    [1;34m38[0m:     cleaner_code = messy_code.css([31m[1;31m'[0m[31m.vitals-text-container[1;31m'[0m[31m[0m)
    [1;34m39[0m:     student_profile.merge!([33m:profile_quote[0m=> cleaner_code.css([31m[1;31m'[0m[31m.profile-quote[1;31m'[0m[31m[0m).text)
    [1;34m40[0m: 
    [1;34m41[0m:   [32mend[0m
    [1;34m42[0m:   [1;34m#goes through the third div section to grab the bio[0m
    [1;34m43[0m:    cleaner_code.each [32mdo[0m |student|
    [1;34m44[0m:      cleaner_code = messy_code.search([31m[1;31m'[0m[31m.details-container .bio-block details-block .bio-content content-holder[1;31m'[0m[31m[0m)
    [1;34m45[0m:      student_profile.merge!([33m:bio[0m=> cleaner_code.css([31m[1;31m'[0m[31m.description-holder[1;31m'[0m[31m[0m).text)
 => [1;34m46[0m:             binding.pry
    [1;34m47[0m:    [32mend[0m
    [1;34m48[0m: [32mend[0m

