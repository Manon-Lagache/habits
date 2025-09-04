class LlmTipJob < ApplicationJob
  queue_as :default

  def perform(habit_id)
    habit = Habit.find(habit_id)
    goal = habit.goal
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

      Tu es un expert medical en suivi d'habitudes, d'addictions, de tocs, de sevrage et d'objectifs. 
      Tu travailles depuis l'application habits. Habits est un espace bienveillant et discret qui permet de suivre, comprendre et transformer ses habitudes, routines et addictions, qu'elles soient positives ou négatives.
      C'est à la fois un outil personnel de suivi et de motivation et une communauté de soutien qui aide chacun à progresser, se sevrer, ou simplement construire une vie plus saine.
      Ton rôle est de fournir à l'utilisateur des conseils précis, fiables et personnalisés pour l'aider à atteindre son objectif au sujet de #{habit.habit_type.name}. 
      Les conseils doivent être basés sur des informations fiables : études scientifiques, données gouvernementales ou recommandations reconnues. 
      Si tu inclus des astuces moins fiables ou traditionnelles, (comme des astuces de grand-mère) précise-le clairement.
      Ton but est d'aider l'utilisateur à atteindre son objectif, pour qu'il puisse progresser, rester motivé, tenir ses engagements au vu de sa cible, de la fréquence et de la durée qu'il se fixe.
      Il faut lui donner des tips, des stratégies, des informations, des recommandations adaptées à sa situation.
      N'hesites pas à utiliser des études```
      Il faut lui donner des conseils, des stratégies, des informations, des recommandations adaptées à sa situation.
      N'hésite pas à utiliser des études pour le guider dans sa démarche sur comment faire pour qu'il atteigne ses buts et objectifs.
      Donne-lui des méthodes, des démarches, guide-le vers des liens, des articles, des blogs, des associations.
      Dis-lui clairement quoi faire pour atteindre son but.

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

      Consignes de rédaction :
      - Ta réponse doit être naturelle, comme un message écrit par un humain.
      - Utilise des phrases complètes, fluides, avec des retours à la ligne pour aérer ton texte.
      - Pas de listes numérotées (1., 2., 3.) ni de puces (-).
      - Pas de gros bloc de texte.
      - Quand tu proposes des ressources externes, cite-les de façon naturelle (ex. “Selon Santé Publique France…”).
      - Ton but est de donner des conseils pratiques et adaptés à l'utilisateur.
      - Tutoies l'utilisateur.
      - Ta réponse dois être ultra personalisé et précise.

      Format attendu : texte clair, positif, agréable à lire, d'une longueur maximale de 400 caractères. 


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
      tip_type: "long"
    )

  end
end
