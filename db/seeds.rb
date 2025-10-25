user1 = User.create!(name: "Lucas Silva", email: "lucas@email.com", password: "123456")
user2 = User.create!(name: "Ana Costa", email: "ana@email.com", password: "123456")
user3 = User.create!(name: "Pedro Almeida", email: "pedro@email.com", password: "123456")

director1 = Director.create!(name: "Francis Ford Coppola")
director2 = Director.create!(name: "Christopher Nolan")
director3 = Director.create!(name: "Robert Zemeckis")
director4 = Director.create!(name: "Peter Jackson")
director5 = Director.create!(name: "The Wachowskis")
director6 = Director.create!(name: "David Fincher")
director7 = Director.create!(name: "Ridley Scott")
director8 = Director.create!(name: "Steven Spielberg")
director9 = Director.create!(name: "James Cameron")
director10 = Director.create!(name: "Quentin Tarantino")

category1  = Category.create!(name: "Ação")
category2  = Category.create!(name: "Romance")
category3  = Category.create!(name: "Comédia")
category4  = Category.create!(name: "Drama")
category5  = Category.create!(name: "Terror")
category6  = Category.create!(name: "Suspense")
category7  = Category.create!(name: "Fantasia")
category8  = Category.create!(name: "Ficção Científica")
category9  = Category.create!(name: "Animação")
category10 = Category.create!(name: "Aventura")
category11 = Category.create!(name: "Musical")
category12 = Category.create!(name: "Documentário")
category13 = Category.create!(name: "Biografia")
category14 = Category.create!(name: "Histórico")
category15 = Category.create!(name: "Policial")

movie1 = Movie.create!(
  title: "O Poderoso Chefão",
  description: "A saga da família Corleone, mostrando poder, família e crime organizado.",
  release_year: 1972,
  duration: 175,
  director: director1,
  category: category4,
  user: user1,
  average_rating: 4.9
)

movie2 = Movie.create!(
  title: "Interestelar",
  description: "Uma equipe de exploradores viaja pelo espaço para garantir a sobrevivência da humanidade.",
  release_year: 2014,
  duration: 169,
  director: director2,
  category: category8,
  user: user2,
  average_rating: 4.8
)

movie3 = Movie.create!(
  title: "A Origem",
  description: "Um ladrão que invade os sonhos das pessoas precisa realizar seu trabalho mais complexo: plantar uma ideia.",
  release_year: 2010,
  duration: 148,
  director: director2,
  category: category8,
  user: user3,
  average_rating: 4.7
)

movie4 = Movie.create!(
  title: "Forrest Gump",
  description: "A incrível vida de Forrest, que testemunha e influencia eventos históricos enquanto busca o amor e a amizade.",
  release_year: 1994,
  duration: 142,
  director: director3,
  category: category4,
  user: user1,
  average_rating: 4.9
)

movie5 = Movie.create!(
  title: "O Senhor dos Anéis: A Sociedade do Anel",
  description: "Frodo e seus amigos embarcam em uma jornada para destruir o Um Anel e salvar a Terra Média.",
  release_year: 2001,
  duration: 178,
  director: director4,
  category: category10,
  user: user2,
  average_rating: 4.8
)

movie6 = Movie.create!(
  title: "Matrix",
  description: "Neo descobre a verdade sobre a realidade e se junta a rebeldes para lutar contra máquinas controladoras.",
  release_year: 1999,
  duration: 136,
  director: director5,
  category: category1,
  user: user3,
  average_rating: 4.7
)

movie7 = Movie.create!(
  title: "Clube da Luta",
  description: "Um homem insatisfeito com sua vida cria um clube secreto de luta que muda sua percepção do mundo.",
  release_year: 1999,
  duration: 139,
  director: director6,
  category: category4,
  user: user2,
  average_rating: 4.6
)

movie8 = Movie.create!(
  title: "Gladiador",
  description: "Maximus, um general romano traído, luta para vingar sua família e restaurar a justiça em Roma.",
  release_year: 2000,
  duration: 155,
  director: director7,
  category: category1,
  user: user3,
  average_rating: 4.8
)

movie9 = Movie.create!(
  title: "Jurassic Park",
  description: "Um parque temático com dinossauros clonados enfrenta um caos quando as criaturas escapam do controle.",
  release_year: 1993,
  duration: 127,
  director: director8,
  category: category10,
  user: user1,
  average_rating: 4.7
)

movie10 = Movie.create!(
  title: "Avatar",
  description: "Em Pandora, um ex-fuzileiro se envolve em uma luta entre humanos e nativos Na'vi por recursos naturais.",
  release_year: 2009,
  duration: 162,
  director: director9,
  category: category10,
  user: user2,
  average_rating: 4.6
)

movie1.poster.attach(io: File.open("db/images/movie1.jpg"), filename: "movie1.jpg")
movie2.poster.attach(io: File.open("db/images/movie2.jpg"), filename: "movie2.jpg")
movie3.poster.attach(io: File.open("db/images/movie3.jpeg"), filename: "movie3.jpeg")
movie4.poster.attach(io: File.open("db/images/movie4.jpeg"), filename: "movie4.jpeg")
movie5.poster.attach(io: File.open("db/images/movie5.jpg"), filename: "movie5.jpg")
movie6.poster.attach(io: File.open("db/images/movie6.jpg"), filename: "movie6.jpg")
movie7.poster.attach(io: File.open("db/images/movie7.jpg"), filename: "movie7.jpg")
movie8.poster.attach(io: File.open("db/images/movie8.jpg"), filename: "movie8.jpg")
movie9.poster.attach(io: File.open("db/images/movie9.jpg"), filename: "movie9.jpg")
movie10.poster.attach(io: File.open("db/images/movie10.jpg"), filename: "movie10.jpg")

Comment.create!(user: user1, movie: movie1, rating: 5, content: "Incrível, efeitos e história impecáveis!", username: user1.name)
Comment.create!(user: user2, movie: movie1, rating: 4, content: "Muito bom, mas poderia ser mais emocionante.", username: user2.name)
Comment.create!(user: user3, movie: movie2, rating: 3, content: "Romântico, mas previsível.", username: user3.name)

tag1  = Tag.create!(name: "Viagem no tempo")
tag2  = Tag.create!(name: "Amor")
tag3  = Tag.create!(name: "Amizade")
tag4  = Tag.create!(name: "Comédia leve")
tag5  = Tag.create!(name: "Aventura épica")
tag6  = Tag.create!(name: "Ficção científica")
tag7  = Tag.create!(name: "Drama familiar")
tag8  = Tag.create!(name: "Suspense psicológico")
tag9  = Tag.create!(name: "Fantasia medieval")
tag10 = Tag.create!(name: "Crime organizado")
tag11 = Tag.create!(name: "Superpoderes")
tag12 = Tag.create!(name: "Distopia")
tag13 = Tag.create!(name: "Viagem espacial")
tag14 = Tag.create!(name: "Mistério")
tag15 = Tag.create!(name: "Guerra")
tag16 = Tag.create!(name: "História real")
tag17 = Tag.create!(name: "Amor proibido")
tag18 = Tag.create!(name: "Investigação")
tag19 = Tag.create!(name: "Inteligência artificial")
tag20 = Tag.create!(name: "Ritual secreto")

MovieTag.create!(movie: movie1, tag: tag10)
MovieTag.create!(movie: movie1, tag: tag7)
MovieTag.create!(movie: movie1, tag: tag14)

MovieTag.create!(movie: movie2, tag: tag6)
MovieTag.create!(movie: movie2, tag: tag13)
MovieTag.create!(movie: movie2, tag: tag1)

MovieTag.create!(movie: movie3, tag: tag19)
MovieTag.create!(movie: movie3, tag: tag14)
MovieTag.create!(movie: movie3, tag: tag1)

MovieTag.create!(movie: movie4, tag: tag7)
MovieTag.create!(movie: movie4, tag: tag3)
MovieTag.create!(movie: movie4, tag: tag16)

MovieTag.create!(movie: movie5, tag: tag5)
MovieTag.create!(movie: movie5, tag: tag14)

MovieTag.create!(movie: movie6, tag: tag19)
MovieTag.create!(movie: movie6, tag: tag6)
MovieTag.create!(movie: movie6, tag: tag14)

MovieTag.create!(movie: movie7, tag: tag14)
MovieTag.create!(movie: movie7, tag: tag18)

MovieTag.create!(movie: movie8, tag: tag15)
MovieTag.create!(movie: movie8, tag: tag9)

MovieTag.create!(movie: movie9, tag: tag13)
MovieTag.create!(movie: movie9, tag: tag6)
MovieTag.create!(movie: movie9, tag: tag12)

MovieTag.create!(movie: movie10, tag: tag13)
MovieTag.create!(movie: movie10, tag: tag5)
