
[1mFrom:[0m /home/michaellandrumstmarie-104469/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 42 Scraper.scrape_profile_page:

    [1;34m21[0m:   [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m22[0m: 
    [1;34m23[0m:     doc = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m24[0m:       student_profile = {}
    [1;34m25[0m:         social_links = []
    [1;34m26[0m:         nodeset = doc.css([31m[1;31m'[0m[31ma[href][1;31m'[0m[31m[0m)
    [1;34m27[0m:         urls = nodeset.map {|element| element[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]}
    [1;34m28[0m: 
    [1;34m29[0m:           student_profile = {
    [1;34m30[0m:           [35mtwitter[0m: urls[[1;34m0[0m],
    [1;34m31[0m:           [35mlinkedin[0m: urls[[1;34m1[0m],
    [1;34m32[0m:           [35mgithub[0m: urls[[1;34m2[0m],
    [1;34m33[0m:           [35myoutube[0m: urls[[1;34m3[0m],
    [1;34m34[0m:           }
    [1;34m35[0m: 
    [1;34m36[0m: 
    [1;34m37[0m:         student_profile[[31m[1;31m"[0m[31mprofile_quote[1;31m"[0m[31m[0m] = doc.css([31m[1;31m"[0m[31m.profile_quote[1;31m"[0m[31m[0m).text
    [1;34m38[0m:         student_profile[[31m[1;31m"[0m[31mbio[1;31m"[0m[31m[0m] = doc.css([31m[1;31m"[0m[31mbio-content content-holder[1;31m"[0m[31m[0m).text
    [1;34m39[0m:         student_profile[[31m[1;31m"[0m[31meducation[1;31m"[0m[31m[0m] = doc.css([31m[1;31m"[0m[31meducation-content content-holder[1;31m"[0m[31m[0m).text
    [1;34m40[0m: 
    [1;34m41[0m: 
 => [1;34m42[0m:         binding.pry
    [1;34m43[0m: [32mend[0m

