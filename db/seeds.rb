Habit.destroy_all
HabitType.destroy_all
Category.destroy_all
Verb.destroy_all
Challenge.destroy_all
Group.destroy_all
GroupMembership.destroy_all
User.destroy_all

user = User.create!(
  pseudo: "toto",
  email: "tata@tot.fr",
  age: 30,
  location: "Bordeaux",
  avatar: Faker::Avatar.image,
  password: "123456"
)

categories = [
  { name: "Santé", color: "#2779A7" },
  { name: "Addictions", color: "#5680E9" },
  { name: "Sport & Fitness", color: "#84CEEB" },
  { name: "Bien-être Mental", color: "#C1C8E4" },
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
  "Bien-être Mental" => [
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

Habit.create!(
  name: "Boire de l'eau",
  category: Category.all.sample,
  visibility: "public",
  user: user,
  verb: Verb.all.sample,
  habit_type: HabitType.all.sample
)


#Challenges seeding

puts "Seeding users..."

# Create users
20.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password", # default password for all
    pseudo: Faker::Games::Pokemon.name, # fun pseudonym
    avatar: Faker::Avatar.image,        # random avatar url
    age: rand(18..60),
    location: Faker::Address.city
  )
end

users = User.all

puts "Users created: #{User.count}"

puts "Seeding challenges..."

challenges_data = [
  { name: "La Quête des 2 Litres", informations: "Boire 2L d'eau par jour avec l'équipe.", duration: 30 },
  { name: "La Guilde des Lecteurs", informations: "Lire 10 pages par jour et partager vos découvertes.", duration: 21 },
  { name: "La Bataille des Pas", informations: "Faire 10 000 pas quotidiens. Classement à la clé !", duration: 14 },
  { name: "Les Chroniqueurs du Journal", informations: "Écrire une pensée quotidienne et la partager.", duration: 15 },
  { name: "L'Ordre du Réveil", informations: "Se lever à 6h30 chaque jour sans exception.", duration: 30 },
  { name: "La Méditation des Mages", informations: "10 minutes de méditation collective par jour.", duration: 21 },
  { name: "Mission Sans Sucre", informations: "30 jours sans sucre ajouté, ensemble !", duration: 30 },
  { name: "L'Arène du Sport", informations: "20 minutes de sport par jour, tout type d'activité accepté.", duration: 30 },
  { name: "Défi Polyglottes", informations: "Apprendre 5 mots par jour d'une langue étrangère.", duration: 21 },
  { name: "La Confrérie des Écrans Éteints", informations: "Pas d'écrans 1h avant le coucher.", duration: 15 }
]

challenges_data.each do |challenge_data|
  Challenge.create!(
    name: challenge_data[:name],
    informations: challenge_data[:informations],
    duration: challenge_data[:duration],
    user: users.sample
  )
end

puts "Challenges created: #{Challenge.count}"

puts "Creating groups..."

# Create one group for each challenge

Challenge.all.each do |challenge|
  group = Group.create!(
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

Habit.all.each do |habit|
  habit.trackers.destroy_all
  8.times do |index|
    Tracker.create(
      date: Date.today - index.days,
      value: habit.goal&.value&.to_i.nil? ? rand(3..10) : rand(3..10) + habit.goal&.value&.to_i,
      habit: habit)
  end
end

puts "\nSeeding completed successfully! 🎉"
