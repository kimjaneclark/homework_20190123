require ('pry')
require_relative ('models/album')
require_relative ('models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => "Adele"})
artist1.save()
artist2 = Artist.new({'name' => "Bastille"})
artist2.save()
artist3 = Artist.new({'name' => "Coldplay"})
artist3.save()

album1 = Album.new({'title' => '21', 'genre' => 'pop', 'artist_id' => artist1.id})
album1.save()
album2 = Album.new({'title' => "25", 'genre' => 'pop', 'artist_id' => artist1.id})
album2.save()
album3 = Album.new({'title' => "Bad Blood", 'genre' => 'alternative', 'artist_id' => artist2.id})
album3.save()
album4 = Album.new({'title' => "X & Y", 'genre' => 'rock', 'artist_id' => artist3.id})
album4.save()
album5 = Album.new({'title' => "Mylo Xyloto", 'genre' => 'rock', 'artist_id' => artist3.id})
album5.save()

album3.delete()
artist2.delete()

album1.genre = 'soul'
album1.update()

artist1.name = "Adele Whatshername"
artist1.update()



binding.pry
nil
