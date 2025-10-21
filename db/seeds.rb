user1 = User.create!(name: "Lucas Silva", email: "lucas@email.com", password: "123456")
user2 = User.create!(name: "Ana Costa", email: "ana@email.com", password: "123456")
user3 = User.create!(name: "Pedro Almeida", email: "pedro@email.com", password: "123456")

director1 = Director.create!(name: "Fernando Meirelles")
director2 = Director.create!(name: "José Padilha")
director3 = Director.create!(name: "Anna Muylaert")

category1 = Category.create!(name: "Ação")
category2 = Category.create!(name: "Romance")
category3 = Category.create!(name: "Comédia")

movie1 = Movie.create!(
    title: "O Mistério do Tempo",
    description: "Um cientista descobre uma forma de viajar no tempo, mas enfrenta consequências inesperadas.",
    release_year: 2023,
    duration: 120,
    director: director1,
    category: category1,
    user: user1,
    average_rating: 4.5
  )
movie2 = Movie.create!(
    title: "Amor nas Alturas",
    description: "Dois pilotos se apaixonam durante uma viagem pelo mundo.",
    release_year: 2022,
    duration: 110,
    director: director2,
    category: category2,
    user: user2,
    average_rating: 4.0
  )
movie3 = Movie.create!(
    title: "Risos e Lágrimas",
    description: "Um grupo de amigos enfrenta desafios da vida enquanto descobre o verdadeiro valor da amizade.",
    release_year: 2024,
    duration: 95,
    director: director3,
    category: category3,
    user: user3,
    average_rating: 4.8
  )

movie4 = Movie.create!(
  title: "Sombras do Amanhã",
  description: "Em um futuro distópico, uma hacker tenta derrubar um sistema autoritário que controla todas as memórias humanas.",
  release_year: 2025,
  duration: 130,
  director: director1,
  category: category2,
  user: user2,
  average_rating: 4.6
)

movie5 = Movie.create!(
  title: "O Eco da Liberdade",
  description: "Um jornalista descobre uma conspiração política enquanto tenta revelar a verdade sobre um governo corrupto.",
  release_year: 2023,
  duration: 118,
  director: director2,
  category: category3,
  user: user1,
  average_rating: 4.3
)

movie6 = Movie.create!(
  title: "Além das Estrelas",
  description: "Uma astronauta luta pela sobrevivência após ficar presa em uma estação espacial danificada.",
  release_year: 2021,
  duration: 125,
  director: director3,
  category: category1,
  user: user3,
  average_rating: 4.7
)

movie7 = Movie.create!(
  title: "A Casa de Vidro",
  description: "Uma família se muda para uma mansão isolada e começa a perceber que está sendo observada por algo misterioso.",
  release_year: 2022,
  duration: 105,
  director: director2,
  category: category1,
  user: user2,
  average_rating: 4.2
)

movie8 = Movie.create!(
  title: "Códigos do Destino",
  description: "Um programador descobre uma sequência matemática que prevê eventos trágicos e precisa decidir entre intervir ou não.",
  release_year: 2024,
  duration: 115,
  director: director1,
  category: category3,
  user: user3,
  average_rating: 4.9
)

movie9 = Movie.create!(
  title: "A Melodia do Silêncio",
  description: "Uma musicista surda encontra uma nova forma de se expressar através das vibrações do som.",
  release_year: 2023,
  duration: 100,
  director: director3,
  category: category2,
  user: user1,
  average_rating: 4.4
)


Comment.create!(user: user1, movie: movie1, rating: 5, content: "Incrível, efeitos e história impecáveis!", username: user1.name)
Comment.create!(user: user2, movie: movie1, rating: 4, content: "Muito bom, mas poderia ser mais emocionante.", username: user2.name)
Comment.create!(user: user3, movie: movie2, rating: 3, content: "Romântico, mas previsível.", username: user3.name)

tag1 = Tag.create!(name: "Viagem no tempo")
tag2 = Tag.create!(name: "Amor")
tag3 = Tag.create!(name: "Amizade")
tag4 = Tag.create!(name: "Comédia leve")

MovieTag.create!(movie: movie1, tag: tag1)
MovieTag.create!(movie: movie2, tag: tag2)
MovieTag.create!(movie: movie3, tag: tag3)
MovieTag.create!(movie: movie3, tag: tag4)
