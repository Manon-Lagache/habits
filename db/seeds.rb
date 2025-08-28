User.destroy_all
Habit.destroy_all
HabitType.destroy_all
Category.destroy_all
Verb.destroy_all

user = User.create!(
  pseudo: "toto",
  email: "tata@tot.fr",
  age: 30,
  location: "Bordeaux",
  avatar: "0000",
  password: "123456"
)

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


p "started seeding"


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

3.times do
  Tip.create!(
    user: user,
    habit_id: Habit.all.sample.id,
    content: "Pense à garder une bouteille d'eau près de ton lit"
  )
end

p "finished seeding"
