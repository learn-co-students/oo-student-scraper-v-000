require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
     student_hash.each {|key, value| self.send(("#{key}="), value)}
    #
    # @name = :name
    # @location = :location
    # @twitter = :twitter
    # @linkedin = :linkedin
    # @github = :github
    # @blog = :blog
    # @profile_quote = :profile_quote
    # @bio = :bio
    # @profile_url = :profile_url
    @@all << self
    # assign the newly created student attributes and values in accordance with the key/value pairs of the hash
  end

#SEND METHOD EXAMPLES

# def start(student_hash)
#   student_hash.each do |key, value|
#     @key = value
#   end
# end
#
#   self.send(:start, :student_hash)

  # def start(*args)
  # "Welcome " + args.join(' ')
  # end
  # end
  # obj = Rubyist.new
  # puts(obj.send(:welcome, "famous", "Rubyists"))   # => Welcome famous Rubyists
  #
  # def say_hello(name)
  #  "#{name} rocks!!"
  # end
  # end
  # obj = Rubyist.new
  # puts obj.send( :say_hello, 'Matz')
#END SEND METHOD EXAMPLES

  def self.create_from_collection(students_array)
    # students_array = Scraper.scrape_index_page(index_url)
    students_array.each do |student|
      Student.new(student)  #{name: "Bacon McRib", location: "Kansas City, MO"}
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
# binding.pry
#  self.create_from_collection(students_array)
