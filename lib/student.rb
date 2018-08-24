require 'pry'

class Student  #DO NOT call on the scraper class here! Needs to be flexible on HOW it gets its info. Simply should be ready to take in info (regarldess of hwere it comes from)
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
  @@all = []

  def initialize(student_hash) #argu of student hash (from any source - not just Scraper class). use the #send Method
    student_hash.each_pair {|k, v| self.send(("#{k}="), "#{v}") }
    #each_pair method is just like each/do but for hashes. look at Key and Value for self and call .send to pass in the value for Key and Value each time they are passed in.
    @@all << self
  end

  def self.create_from_collection(students_array) #Iterate over the array of hashes and create new indivial student. delete duplicates! (Sushanth B is listed twice!)
    students_array.each do |student|
      if self == student
        nil
        else
        self.new(student)
      end
    end
  end

  def add_student_attributes(attributes_hash) #iterate over the hashes#use metaprogramming to dynamically assign the student attributes and values.. #use the send method. exact same as the initialize!
   attributes_hash.each_pair {|k, v| self.send(("#{k}="), "#{v}") }
  end

  def self.all
    @@all
  end

end


#hippo video:
#class constructor:
#def self.new_from_wikipedia(url)
#animal = Animal.new
#properties = AnimalScraper.new(url)
#properties.eacu do |k,v| #(key, value)
#animal.send("#{k}=", v)
#end

#class dog
#attr_accessor :name
#end
# fido = Dog.new => new dog instance
# fido.name = "Fido" => "Fido"
# fido.send("name=", "Rover) => "Rover"
