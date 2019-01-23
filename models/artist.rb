require_relative ('../db/sql_runner')
require_relative ('album.rb')

class Artist
    attr_accessor :name
    attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

def save()
  sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
  values = [@name]
  result = SqlRunner.run(sql, values)
  @id = result[0] ["id"].to_i
end

def self.delete_all()
  sql = "DELETE FROM artists"
  albums = SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM artists"
  artists = SqlRunner.run(sql)
  return artists.map { |artist| Artist.new(artist)}
end

def album
  sql = "SELECT * FROM albums WHERE artist_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  albums = results.map { |album| Album.new(album)}
  return albums
end

def delete
  sql = "DELETE FROM albums WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE artists SET
  name = $1 WHERE ID = $2"
  values = [@name, @id]
  SqlRunner.run(sql, values)
end

def self.find(id)
  sql = "SELECT * FROM artists WHERE ID = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  artist = Artist.new(result.first)
  return artist
end


end
