class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each{|key, value| self.send("#{key}=", value)}
    #sophie.send("name=", "Sophie"), calls methods on objects, abstracts the specific method call , self refers to user instance that is bein initialized
    #at that time
    @@all << self
  end

    def self.create_from_collection(students_array)
      doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
      students_array.each do |student_hash|
      Student.new(student_hash)
  end

#uses scraper class to get student attributes
#uses hash to set additional attributes
  def add_student_attributes(attributes_hash)
    #doc = Nokogiri::HTML(open("./fixtures/student-site/#{student.attr('href')}")
      attributes_hash.each do |key, value|
        self.send("#{key}=", value)
  end
    self
 end

  def self.all
    @@all
  end

  end
 end
