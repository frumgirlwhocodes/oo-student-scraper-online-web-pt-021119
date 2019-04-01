
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html=open(index_url)
    doc=Nokogiri::HTML(html)
  students_array=[]
  doc.css(".student-card").each do |student| 
  hash={} 
  hash[:name]= student.css("h4.student-name").text
  hash[:location]=student.css("p.student-location").text 
  hash[:profile_url]=student.children[1].values.first
  students_array << hash 
end
students_array
end

  def self.scrape_profile_page(profile_url)
  html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    hash = {}
    profile_page.css('.social-icon-container a').each do |icon|
      student_name = profile_page.css('.profile-name').text
      student_fname, student_lname = student_name.split(" ")

      hash[:twitter] = icon["href"] unless !hash[:twitter].nil? if icon["href"].include?("twitter")

      hash[:linkedin] = icon["href"] unless !hash[:linkedin].nil? if icon["href"].include?("linkedin")

      hash[:github] = icon["href"] unless !hash[:github].nil? if icon["href"].include?("github")

      hash[:blog] = icon["href"] unless !hash[:blog].nil? if icon["href"].include?(student_fname.downcase) && !icon["href"].include?("linkedin") && !icon["href"].include?("twitter") && !icon["href"].include?("github")
    end

    hash[:profile_quote] = profile_page.css('div.profile-quote').text
    hash[:bio] = profile_page.css('.bio-content .description-holder').text.strip
    hash
  end



end

