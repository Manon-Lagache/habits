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
  { name: "La Quête des 2 Litres", informations: "Boire 2L d'eau par jour avec l'équipe.", duration: 30, image: "logo-habits.png"},
  { name: "La Guilde des Lecteurs", informations: "Lire 10 pages par jour et partager vos découvertes.", duration: 21, image: "logo-habits.png" },
  { name: "La Bataille des Pas", informations: "Faire 10 000 pas quotidiens. Classement à la clé !", duration: 14, image: "logo-habits.png" },
  { name: "Les Chroniqueurs du Journal", informations: "Écrire une pensée quotidienne et la partager.", duration: 15, image: "logo-habits.png" },
  { name: "L'Ordre du Réveil", informations: "Se lever à 6h30 chaque jour sans exception.", duration: 30, image: "logo-habits.png" },
  { name: "La Méditation des Mages", informations: "10 minutes de méditation collective par jour.", duration: 21, image: "logo-habits.png" },
  { name: "Mission Sans Sucre", informations: "30 jours sans sucre ajouté, ensemble !", duration: 30, image: "logo-habits.png" },
  { name: "L'Arène du Sport", informations: "20 minutes de sport par jour, tout type d'activité accepté.", duration: 30, image: "logo-habits.png" },
  { name: "Défi Polyglottes", informations: "Apprendre 5 mots par jour d'une langue étrangère.", duration: 21, image: "logo-habits.png" },
  { name: "La Confrérie des Écrans Éteints", informations: "Pas d'écrans 1h avant le coucher.", duration: 15, image: "logo-habits.png" }
]

challenges_data.each do |challenge_data|
  Challenge.create!(
    name: challenge_data[:name],
    informations: challenge_data[:informations],
    duration: challenge_data[:duration],
    user: users.sample,
    image: challenge_data[:image]
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

category = Category.find_by(name: "Santé")
habit_type = HabitType.find_by(name: "Consommation d'eau")
verb = Verb.find_by(name: "Suivre")

habit = Habit.create!(
  name: "Boire de l'eau",
  visibility: "public",
  user: user,
  category: category,
  habit_type: habit_type,
  verb: verb
)

puts "Habit créé avec l'ID: #{habit.id}" if habit.persisted?


goal = Goal.create(
  habit_id: habit.id,
  value: 2,
  frequency: "daily",
  target_day: "indefinite",
  is_public: true,
  start_date: nil,
  end_date: nil,
  end_type: "indefinite"
)

p goal

Habit.all.each do |habit|
  habit.trackers.destroy_all
  8.times do |index|
    Tracker.create(
      date: Date.today - index.days,
      value: habit.goal&.value&.to_i.nil? ? rand(3..10) : rand(3..10) + habit.goal&.value&.to_i,
      habit: habit)
  end
end

start_date = goal.start_date || habit.created_at.to_date
end_date =
  case goal.end_type
  when "period"
    goal.end_date.presence || start_date
  when "target_day"
    goal.target_day.presence || start_date
  when "indefinite"
    start_date + 5.years
  else
    start_date
  end

prompt = <<~PROMPT
  Tu es un assistant expert en suivi d'habitudes, d'addictions, de tocs, de sevrage et d'objectifs.
  Ton rôle est de fournir à l'utilisateur des conseils précis, fiables et personnalisés pour l'aider à atteindre son objectif au sujet de #{habit.habit_type.name}.
  Les conseils doivent être basés sur des informations fiables : études scientifiques, données gouvernementales ou recommandations reconnues.

  Voici les informations sur l'habitude et l'objectif de l'utilisateur :

  - Catégorie : #{habit.category.name}
  - Type d'habitude : #{habit.habit_type.name}
  - Verbe (objectif principal) : #{habit.verb.name}
  - Valeur cible : #{goal.value} #{habit.habit_type.unit if habit.habit_type.unit.present?}
  - Fréquence : #{goal.frequency}
  - Type de fin (end_type) : #{goal.end_type}
  - Date de début : #{start_date.strftime("%d/%m/%Y")}
  - Date de fin : #{end_date.strftime("%d/%m/%Y") rescue 'indéfinie'}
  - Progression actuelle : #{goal.progress || 'non définie'}

  Format attendu : phrase simple en moins de 74 caractères, structurée et compréhensible par un utilisateur non expert
PROMPT

chat = RubyLLM.chat(model: "gpt-4o").with_temperature(0.7)
response = chat.ask(
  "Tu es un assistant bienveillant et expert en suivi d'addictions et d'habitudes.\n\n#{prompt}"
)
tip_text = response.content || "Aucun conseil généré."


Tip.create!(
  habit: habit,
  user: habit.user,
  content: tip_text,
  tip_type: "daily"
)

Tip.create!(
  habit: habit,
  user: habit.user,

  content: tip_text,
  tip_type: "long"
)

puts "\nSeeding completed successfully! 🎉"
