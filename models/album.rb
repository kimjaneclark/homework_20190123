require_relative('../db/sql_runner')
require_relative('artist.rb')

class Album
  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

def save()
    sql = "INSERT INTO albums (
          title,
          genre,
          artist_id
          )
          VALUES
          ($1, $2, $3)
          RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0] ["id"].to_i
end

def self.delete_all()
  sql = "DELETE FROM albums"
  albums = SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM albums"
  albums = SqlRunner.run(sql)
  return albums.map {|album| Album.new(album)}
end

def artist
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [@artist_id]
  results = SqlRunner.run(sql, values)
  artist_data = results[0]
  artist = Artist.new(artist_data)
end

def delete()
  sql = "DELETE FROM albums WHERE id = $1"
  values =[@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE albums SET (
  title,
  genre,
  artist_id
  ) = ($1, $2, $3) WHERE ID = $4"
  values = [@title, @genre, @artist_id, @id]
  SqlRunner.run(sql, values)
end

def self.find
  sql = "SELECT * FROM albums WHERE ID = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  album = Album.new(result.first)
  return album
end



end
