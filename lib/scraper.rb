require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    
    # binding.pry
    # name = x.css("h4").first.text
    # location = x.css("p").first.text
    # url = x.css("div.student-card a").first.attribute("href").value
    
    index_page.css("div.student-card").each_with_index do |card,i|
      
      students[i] = {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url=> card.css("a").attribute("href").value
        }
      
      
    end 
    students 
  end

  def self.scrape_profile_page(profile_url)
    index_page = Nokogiri::HTML(open(profile_url))
    student = {}
      # :twitter => ,
      # :linkedin => ,
      # :github => ,
      # :blog => ,
      
    index_page.css("div.social-icon-container a").each do |social|
      
      if social.attribute("href").value.include?("twitter")
        student[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin") 
        student[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student[:github] = social.attribute("href").value
      else 
        student[:blog] = social.attribute("href").value
      end 
      
      student[:profile_quote] = index_page.css("div.profile-quote").text
      student[:bio] = index_page.css("div.description-holder p").text
    end 
  student    
  end
  


end

