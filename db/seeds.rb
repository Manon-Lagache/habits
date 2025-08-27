User.destroy_all
HabitType.destroy_all
Habit.destroy_all
categories = [
  { name: "Santé", color: "#4CAF50" },
  { name: "Addictions", color: "#F44336" },
  { name: "Sport & Fitness", color: "#2196F3" },
  { name: "Bien-être Mental", color: "#9C27B0" },
  { name: "Productivité", color: "#FF9800" },
  { name: "Nutrition", color: "#795548" }
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

verbs = ["Suivre", "Augmenter", "Diminuer", "Arrêter"]

habit_types.each do |category_name, types|
  category = Category.find_by!(name: category_name)
  types.each do |ht|
    HabitType.create!(
      name: ht[:name],
      unit: ht[:unit],
      verb: verbs.join(","),
      category: category
    )
  end
end
p "created #{HabitType.all.count} habit types"

categories.each do |attrs|
  Category.find_or_create_by!(name: attrs[:name]) do |c|
    c.color = attrs[:color]
  end
end



p "started seeding"

user = User.create!(
  email: "tata@tot.fr",
  password: "123456",
  pseudo: "tata",
  avatar: "oooo",
  age: 30,
  location: "BDX"
)

p "creating habit.."

5.times do
  Habit.create!(
    name: "Boire de l'eau",
    category: Category.all.sample,
    visibility: "public",
    user_id: user.id,
    habit_type_id: HabitType.all.sample.id
  )
end

p "created #{Habit.all.count} Habits"

# 5.times do
#   Tracker.create!(
#     date: Date.today,
#     value: rand(0..5),
#     habit: habit_clope
#   )
# end

# 5.times do
#   Tracker.create!(
#     date: Date.today,
#     value: rand(0..5),
#     habit: habit_read
#   )
# end

# 5.times do
#   Tracker.create!(
#     date: Date.today,
#     value: rand(0..5),
#     habit: habit_water
#   )
# end

# smoking_tip = Tip.create!(
#   content: "Pour arrêter de fumer, remplace la cigarette par une action saine dès que l’envie te prend.",
#   habit: habit_clope,
#   user: user
# )
# p smoking_tip

# water_tip = Tip.create!(
#   content: "Bois un grand verre d’eau dès le réveil et garde ta bouteille toujours avec toi.",
#   habit: habit_water,
#   user: user
# )
# p water_tip

# reading_tip = Tip.create!(
#   content: "Lis chaque jour un peu, même 5 minutes, pour en faire une habitude durable.",
#   habit: habit_read,
#   user: user
# )
# p reading_tip


p "finished seeding"
