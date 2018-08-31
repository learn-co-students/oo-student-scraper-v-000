
[1mFrom:[0m /home/aljimenez5/oo-student-scraper-v-000/lib/scraper.rb @ line 33 Scraper.scrape_profile_page:

    [1;34m25[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m26[0m:   profile_page = [1;34;4mNokogiri[0m::HTML([1;34;4mFile[0m.read(profile_url))
    [1;34m27[0m: 
    [1;34m28[0m:   students_profile = {}
    [1;34m29[0m:   profile_page.css([31m[1;31m"[0m[31mdiv.vitals-container[1;31m"[0m[31m[0m).each [32mdo[0m |student_info|
    [1;34m30[0m:     urls = []
    [1;34m31[0m:     student_info.css([31m[1;31m"[0m[31mdiv.social-icon-container[1;31m"[0m[31m[0m).map {|url| urls << url}
    [1;34m32[0m:     twitter_info = student_info.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value 
 => [1;34m33[0m:     binding.pry
    [1;34m34[0m:   [1;34m# <div class="vitals-container">[0m
    [1;34m35[0m:   [1;34m#     <div class="profile-photo" id="ryan-johnson-card"></div>[0m
    [1;34m36[0m:   [1;34m#     <div class="social-icon-container">[0m
    [1;34m37[0m:   [1;34m#       <a href="https://twitter.com/empireofryan"><img class="social-icon" src="../assets/img/twitter-icon.png"></a>[0m
    [1;34m38[0m:   [1;34m#       <a href="https://www.linkedin.com/in/ryan-johnson-321629ab"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>[0m
    [1;34m39[0m:   [1;34m#       <a href="https://github.com/empireofryan"><img class="social-icon" src="../assets/img/github-icon.png"></a>[0m
    [1;34m40[0m:   [1;34m#       <a href="https://www.youtube.com/watch?v=C22ufOqDyaE"><img class="social-icon" src="../assets/img/rss-icon.png"></a>[0m
    [1;34m41[0m:   [1;34m#     </div>[0m
    [1;34m42[0m:   [1;34m#     <div class="vitals-text-container">[0m
    [1;34m43[0m:   [1;34m#       <h1 class="profile-name">Ryan Johnson</h1>[0m
    [1;34m44[0m:   [1;34m#       <h2 class="profile-location">New York, NY</h2>[0m
    [1;34m45[0m:   [1;34m#       <div class="profile-quote">"The mind is everything. What we think we become." - Buddha</div>[0m
    [1;34m46[0m:   [1;34m#     </div>[0m
    [1;34m47[0m:   [1;34m#   </div>[0m
    [1;34m48[0m:   [32mend[0m
    [1;34m49[0m: [32mend[0m

