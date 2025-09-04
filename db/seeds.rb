Habit.destroy_all
HabitType.destroy_all
Category.destroy_all
Verb.destroy_all
Challenge.destroy_all
Group.destroy_all
GroupMembership.destroy_all
User.destroy_all

user = User.create!(
  pseudo: "Guillem",
  email: "guillem@guillem.fr",
  age: 30,
  location: "Bordeaux",
  avatar: "aiony-haust-3TLl_97HNJo-unsplash.jpg",
  password: "123456",
  xp_reward: 300
)

categories = [
  { name: "Santé", color: "#2779A7" },
  { name: "Addictions", color: "#5680E9" },
  { name: "Sport & Fitness", color: "#84CEEB" },
  { name: "Bien-être", color: "#C1C8E4" },
  { name: "Productivité", color: "#8860D0" },
  { name: "Nutrition", color: "#FF9398" }
]

categories.each do |category|
  Category.create!(
    name: category[:name],
    color: category[:color]
  )
end

habit_types = {
  "Addictions" => [
    { name: "Alcool", unit: "cl" },
    { name: "Cigarette", unit: "pièces" },
    { name: "Cannabis", unit: "grammes" },
    { name: "Pornographie", unit: "minutes" },
    { name: "Jeux d'argent", unit: "sessions" },
    { name: "Réseaux sociaux", unit: "minutes" },
    { name: "Caféine", unit: "tasses" },
    { name: "Sodas", unit: "canettes" },
    { name: "Fast-food", unit: "repas" },
    { name: "Shopping compulsif", unit: "achats" }
  ],
  "Productivité" => [
    { name: "Lecture", unit: "pages" },
    { name: "Tâches quotidiennes", unit: "tâches" },
    { name: "Projets persos", unit: "heures" },
    { name: "Apprentissage d'une langue", unit: "minutes" },
    { name: "Emails traités", unit: "emails" },
    { name: "Réunions productives", unit: "heures" },
    { name: "Écriture", unit: "pages" },
    { name: "Codage", unit: "heures" },
    { name: "Planification", unit: "minutes" },
    { name: "Organisation bureau", unit: "sessions" }
  ],
  "Nutrition" => [
    { name: "Gluten", unit: "g" },
    { name: "Sucre", unit: "g" },
    { name: "Calories", unit: "kcal" },
    { name: "Hydratation", unit: "litres" },
    { name: "Protéines", unit: "g" },
    { name: "Fruits", unit: "portions" },
    { name: "Légumes", unit: "portions" },
    { name: "Fast-food", unit: "repas" },
    { name: "Produits laitiers", unit: "portions" },
    { name: "Snacks", unit: "pièces" }
  ],
  "Santé" => [
    { name: "Consommation d'eau", unit: "litres" },
    { name: "Prise de médicaments", unit: "comprimés" },
    { name: "Visites médicales", unit: "visites" },
    { name: "Sommeil", unit: "heures" },
    { name: "Contrôle de tension", unit: "mesures" },
    { name: "Poids", unit: "kg" },
    { name: "Glycémie", unit: "mg/dl" },
    { name: "Vaccinations", unit: "doses" },
    { name: "Check-up yeux", unit: "sessions" },
    { name: "Hygiène", unit: "sessions" }
  ],
  "Sport & Fitness" => [
    { name: "Running", unit: "km" },
    { name: "Musculation", unit: "kg" },
    { name: "Yoga", unit: "minutes" },
    { name: "Natation", unit: "laps" },
    { name: "Cyclisme", unit: "km" },
    { name: "Étirements", unit: "minutes" },
    { name: "Marche", unit: "km" },
    { name: "HIIT", unit: "minutes" },
    { name: "Sports collectifs", unit: "heures" },
    { name: "Pilates", unit: "minutes" }
  ],
  "Bien-être" => [
    { name: "Méditation", unit: "minutes" },
    { name: "Journal", unit: "pages" },
    { name: "Respiration", unit: "minutes" },
    { name: "Gratitude", unit: "entrées" },
    { name: "Promenades", unit: "minutes" },
    { name: "Musique relaxante", unit: "minutes" },
    { name: "Temps sans écran", unit: "minutes" },
    { name: "Yoga doux", unit: "minutes" },
    { name: "Visualisation", unit: "minutes" },
    { name: "Auto-réflexion", unit: "minutes" }
  ]
}

habit_types.each do |category_name, types|
  category = Category.find_by!(name: category_name)
  types.each do |ht|
    habit_type = HabitType.create!(
      name: ht[:name],
      unit: ht[:unit],
      category: category
    )
  end
end

verbs = ["Suivre", "Augmenter", "Diminuer", "Arrêter"]
verbs.each do |v|
  Verb.create!(name: v)
end

p "created #{HabitType.count} habit types"
p "created #{Verb.count} verbs"




#Challenges seeding

puts "Seeding users..."

# Create users

Dir.each_child('./app/assets/images/avatars') do |filename|
  p filename
  avatar = User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    pseudo: Faker::Games::Pokemon.name,
    avatar: filename,
    age: rand(18..60),
    location: Faker::Address.city,
    xp_reward: 100 + rand(0..900)
  )
  p avatar
end


users = User.all

puts "Users created: #{User.count}"

puts "Seeding challenges..."

challenges_data = [
  {
    name: "Hydratation maximale",
    description: "Restez hydraté chaque jour en atteignant votre quota d'eau.",
    objective: "Boire 2 litres d'eau par jour.",
    duration: 30,
    start_date: Date.new(2025, 9, 1),
    end_date: Date.new(2025, 9, 30),
    xp_reward: 150,
    image: "challenges/drink-water.jpg"
  },
  {
    name: "10000 pas, zéro excuses ",
    description: "Intégrez davantage de mouvement dans votre quotidien.",
    objective: "Faire au moins 10 000 pas chaque jour.",
    duration: 21,
    start_date: Date.new(2025, 9, 5),
    end_date: Date.new(2025, 9, 25),
    xp_reward: 200,
    image: "challenges/walk.jpg"
  },
  {
    name: "Zen restons zen ",
    description: "Offrez-vous une pause mentale pour réduire le stress.",
    objective: "Méditer 10 minutes chaque jour.",
    duration: 14,
    start_date: Date.new(2025, 9, 10),
    end_date: Date.new(2025, 9, 24),
    xp_reward: 100,
    image: "challenges/meditation.jpg"
  },
  {
    name: "Zéro sucre ajouté ",
    description: "Prenez soin de votre énergie et de votre santé.",
    objective: "Éviter les aliments et boissons sucrés.",
    duration: 21,
    start_date: Date.new(2025, 9, 15),
    end_date: Date.new(2025, 10, 5),
    xp_reward: 250,
    image: "challenges/no-sugar.jpg"
  },
  {
    name: "Sommeil de champion ",
    description: "Améliorez la qualité de votre sommeil.",
    objective: "Se coucher avant 23h chaque soir.",
    duration: 30,
    start_date: Date.new(2025, 10, 1),
    end_date: Date.new(2025, 10, 30),
    xp_reward: 200,
    image: "challenges/sleep.jpg"
  },
  {
    name: "Gratitude attitude",
    description: "Cultivez un état d'esprit positif.",
    objective: "Écrire 3 choses positives chaque jour.",
    duration: 21,
    start_date: Date.new(2025, 10, 5),
    end_date: Date.new(2025, 10, 25),
    xp_reward: 120,
    image: "challenges/journaling.jpg"
  },
  {
    name: "Détox digitale",
    description: "Reprenez du temps pour vous en réduisant les écrans.",
    objective: "Maximum 1h/jour sur les réseaux sociaux.",
    duration: 14,
    start_date: Date.new(2025, 10, 10),
    end_date: Date.new(2025, 10, 24),
    xp_reward: 180,
    image: "challenges/digital-detox.jpg"
  },
  {
    name: "Matins sportifs",
    description: "Commencez la journée en pleine énergie.",
    objective: "Faire 20 minutes d'exercice chaque matin.",
    duration: 30,
    start_date: Date.new(2025, 11, 1),
    end_date: Date.new(2025, 11, 30),
    xp_reward: 300,
    image: "challenges/exercise.jpg"
  },
  {
    name: "Littérature quotidienne",
    description: "Stimulez votre esprit et réduisez le temps d'écran.",
    objective: "Lire au moins 15 minutes chaque jour.",
    duration: 21,
    start_date: Date.new(2025, 11, 5),
    end_date: Date.new(2025, 11, 25),
    xp_reward: 150,
    image: "challenges/read.jpg"
  },
  {
    name: "Défi polyglotte",
    description: "Progressez chaque jour dans une langue étrangère.",
    objective: "Pratiquer 15min de langue étrangère par jour.",
    duration: 14,
    start_date: Date.new(2025, 11, 10),
    end_date: Date.new(2025, 11, 24),
    xp_reward: 120,
    image: "challenges/study.jpg"
  }
]

challenges_data.each do |challenge_data|
  Challenge.create!(
    name: challenge_data[:name],
    description: challenge_data[:description],
    objective: challenge_data[:objective],
    duration: challenge_data[:duration],
    start_date: challenge_data[:start_date],
    end_date: challenge_data[:end_date],
    xp_reward: challenge_data[:xp_reward],
    image: challenge_data[:image],
    user: users.sample
  )
end

puts "Challenges created: #{Challenge.count}"

puts "Creating groups..."

# Create one group for each challenge

Challenge.all.each do |challenge|
  Group.create!(
    challenge: challenge
  )

  puts "Created group for challenge: #{challenge.name} (created by: #{challenge.user.pseudo})"
end

puts "Groups created: #{Group.count}"

puts "Adding members to groups..."



# Add multiple users to each group via GroupMemberships

Group.all.each do |group|
  members_count = rand(3..8)

  selected_members = users.sample(members_count)
  selected_members.each do |user|
    GroupMembership.create!(
      group: group,
      user: user
    )
  end

  puts "#{group.challenge.name}: #{group.users.count} members"
end

puts "Groups created: #{Group.count}"
puts "Users: #{User.count}"
puts "Challenges: #{Challenge.count}"
puts "Groups: #{Group.count}"
puts "Group Memberships: #{GroupMembership.count}"

Challenge.all.each do |challenge|
  group = challenge.group
  puts "#{challenge.name}: #{group.users.count} participants (created by #{challenge.user.pseudo})"
end

category = Category.find_by(name: "Santé")
habit_type = HabitType.find_by(name: "Consommation d'eau")
verb = Verb.find_by(name: "Suivre")

habit_water = Habit.create!(
  name: "Boire de l'eau",
  visibility: "public",
  user: user,
  category: category,
  habit_type: habit_type,
  verb: verb
)

puts "Habit créé avec l'ID: #{habit_water.id}" if habit_water.persisted?


goal_water = Goal.create(
  habit_id: habit_water.id,
  value: 2,
  frequency: "daily",
  target_day: "indefinite",
  is_public: true,
  start_date: nil,
  end_date: nil,
  end_type: "indefinite"
)

p goal_water

category = Category.find_by(name: "Addictions")
habit_type = HabitType.find_by(name: "Cigarette")
verb = Verb.find_by(name: "Arrêter")

habit_cigarette = Habit.create!(
  name: "Arrêter la clope",
  visibility: "public",
  user: user,
  category: category,
  habit_type: habit_type,
  verb: verb
)

puts "Habit créé avec l'ID: #{habit_cigarette.id}" if habit_cigarette.persisted?


goal_cigarette = Goal.create(
  habit_id: habit_cigarette.id,
  value: 10,
  frequency: "daily",
  target_day: "20260101",
  is_public: true,
  start_date: nil,
  end_date: nil,
  end_type: "target_day"
)

p goal_cigarette


habit_water.trackers.destroy_all
8.times do |index|
  Tracker.create(
    date: Date.today - (index.days + 1),
    value: rand(1..3),
    habit: habit_water
  )
end

habit_cigarette.trackers.destroy_all
8.times do |index|
  Tracker.create(
    date: Date.today - (index.days + 1),
    value: rand(9..18),
    habit: habit_cigarette
  )
end


Tip.create!(
  habit: habit_water,
  user: habit_water.user,
  content: "Fixe des rappels pour boire 250 ml d'eau 8 fois par jour.",
  tip_type: "daily"
)

Tip.create!(
  habit: habit_cigarette,
  user: habit_cigarette.user,
  content: "Note chaque cigarette évitée, tu verras ton progrès grandir chaque jour",
  tip_type: "daily"
)

Tip.create!(
  habit: habit_water,
  user: habit_water.user,
  content: "Emporte une gourde de 500 ml partout avec toi :
  une le matin, une à midi, une dans l’après-midi et une le soir.
  En 4 étapes simples, tu atteins 2 litres par jour sans effort et restes bien hydraté",
  tip_type: "long"
)

Tip.create!(
  habit: habit_cigarette,
  user: habit_cigarette.user,
  content: "Diminue doucement ta consommation :
  commence par une cigarette de moins chaque jour,
  puis augmente le rythme. Chaque petite victoire compte et te
  rapproche d’un 1er janvier sans tabac",
  tip_type: "long"
)
puts "\nSeeding completed successfully! 🎉"
