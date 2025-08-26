User.destroy_all
HabitType.destroy_all
Habit.destroy_all
Tracker.destroy_all
Tip.destroy_all

p "started seeding"

user = User.create!(
  email: "tata@tot.fr",
  password: "123456",
  pseudo: "tata",
  avatar: "oooo",
  age: 30,
  location: "BDX"
)
habit_type = HabitType.create!(
  name: "cigarette",
  unit: "cigarettes",
  verb: "arrêter"
)
p habit_type

habit = Habit.create!(
  user: user,
  name: "Arrêter de fumer dans 6 mois",
  habit_type: habit_type,
  visibility: "public",
  category: "Santé"
)
p habit

tracker = Tracker.create!(
  date: Date.today,
  value: 5,
  habit: habit
)

p tracker

smoking_tip = Tip.create!(
  content: "Pour arrêter de fumer, remplace la cigarette par une action saine dès que l’envie te prend.",
  habit: habit,
  user: user
)
p smoking_tip

water_tip = Tip.create!(
  content: "Bois un grand verre d’eau dès le réveil et garde ta bouteille toujours avec toi.",
  habit: habit,
  user: user
)
p water_tip

reading_tip = Tip.create!(
  content: "Lis chaque jour un peu, même 5 minutes, pour en faire une habitude durable.",
  habit: habit,
  user: user
)
p reading_tip

p "finished seeding"
