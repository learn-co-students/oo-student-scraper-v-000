class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @student_hash.each{|key, value| self.send("#{key}=", value)}
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    #modo migliore per risolverlo: MASS ASSIGNMENT (create obj from different environments). Assegna le coppie key/value all'instance della classe usando send
    #con un key= method and an attribute.
    attributes_hash.each{|key, value| self.send("#{key}=", value)}
    #attributes_hash.each do |attribute|
      #@bio = attributes_hash[:bio]
      #@blog = attributes_hash[:blog]
      #@linkedin = attributes_hash[:linkedin]
      #@profile_quote = attributes_hash[:profile_quote]
      #@twitter = attributes_hash[:twitter]
    #end
  end

  def self.all
    @@all
  end
end
