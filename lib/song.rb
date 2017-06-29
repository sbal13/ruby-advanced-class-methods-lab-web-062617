require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def initialize(artist="")
  	@artist_name = artist
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
  	new_song = self.new
  	new_song.save
  	new_song

  end

  def self.new_by_name(song_name,artist ="")
  	new_song = Song.new(artist)
  	new_song.name = song_name
  	new_song
  end

  def self.create_by_name(song_name)
  	self.create.name = song_name
  	self.all.last
  end

  def self.find_by_name(name)
  	self.all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
  	self.all.include?(name) ? self.find_by_name(name) : self.new_by_name(name)
  end

  def self.alphabetical
  	self.all.sort_by do |song|
  		song.name
  	end
  end

  def self.new_from_filename(filename)
  	artist, song_name = split_filename(filename)

  	self.new_by_name(song_name, artist)
  end

  def self.create_from_filename(filename)
  	artist, song_name = split_filename(filename)

  	self.create_by_name(song_name).artist_name = artist
  	self.all.last
  end

  def self.destroy_all
  	@@all = []
  end

  private

	  def self.split_filename(filename)
	  	artist_and_song = filename.split(" - ")
	  	artist = artist_and_song[0]
	  	song_name = artist_and_song[1].split(".")[0]

	  	return artist, song_name
	  end

end
