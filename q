
[1mFrom:[0m /home/jdaniel1008/oo-student-scraper-v-000/lib/scraper.rb @ line 24 Scraper.scrape_profile_page:

    [1;34m19[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m20[0m:   student_profile = []
    [1;34m21[0m:   html = open(profile_url)
    [1;34m22[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m23[0m:   doc.css([31m[1;31m"[0m[31m.social-icon-container a[href][1;31m"[0m[31m[0m).each [32mdo[0m |network|
 => [1;34m24[0m:     binding.pry
    [1;34m25[0m:     [32mif[0m network.values[[1;34m0[0m].include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m)
    [1;34m26[0m:         student_twitter = network.values[[1;34m0[0m]
    [1;34m27[0m:     [32melsif[0m network.values[[1;34m0[0m].include?([31m[1;31m"[0m[31mlinked[1;31m"[0m[31m[0m)
    [1;34m28[0m:       student_linked_in = doc.css([31m[1;31m"[0m[31m.social-icon-container a[href][1;31m"[0m[31m[0m)[[1;34m1[0m].values[[1;34m0[0m]
    [1;34m29[0m:     [32melsif[0m network.values[[1;34m0[0m].include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m)
    [1;34m30[0m:       student_github = doc.css([31m[1;31m"[0m[31m.social-icon-container a[href][1;31m"[0m[31m[0m)[[1;34m2[0m].values[[1;34m0[0m]
    [1;34m31[0m:     [32melse[0m
    [1;34m32[0m:       student_blog = doc.css([31m[1;31m"[0m[31m.social-icon-container a[href][1;31m"[0m[31m[0m)[[1;34m3[0m].values[[1;34m0[0m]
    [1;34m33[0m:     [32mend[0m
    [1;34m34[0m:       student_profile_quote = doc.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text
    [1;34m35[0m:       student_bio = doc.css([31m[1;31m"[0m[31m.description-holder p[1;31m"[0m[31m[0m).text
    [1;34m36[0m:   [32mend[0m
    [1;34m37[0m:   student_profile = {
    [1;34m38[0m:     [35mtwitter[0m: student_twitter,
    [1;34m39[0m:     [35mlinkedin[0m: student_linked_in,
    [1;34m40[0m:     [35mgithub[0m: student_github,
    [1;34m41[0m:     [35mblog[0m: student_blog,
    [1;34m42[0m:     [35mprofile_quote[0m: student_profile_quote,
    [1;34m43[0m:     [35mbio[0m: student_bio
    [1;34m44[0m:   }
    [1;34m45[0m:   student_profile
    [1;34m46[0m: [32mend[0m

