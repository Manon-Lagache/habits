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
      Tu es un assistant expert en suivi d'habitudes et d'objectifs. 
      Ton rôle est de fournir à l'utilisateur des conseils précis, fiables et personnalisés pour l'aider à atteindre son objectif au sujet de #{habit.habit_type.name}. 
      Les conseils doivent être basés sur des informations fiables : études scientifiques, données gouvernementales ou recommandations reconnues. 
      Si tu inclus des astuces moins fiables ou traditionnelles, précise-le clairement.

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

      Ton conseil doit inclure des choses comme:
      Comment progresser étape par étape vers l'objectif; Stratégies pour rester motivé et tenir ses engagements; Informations fiables sur l'habitude ou le comportement ciblé; Recommandations adaptées à la fréquence et à la durée de l'objectif.


      Format attendu : texte simple en moins de 74 caractères, en une seule phrase, structuré et compréhensible par un utilisateur non expert d'une longueur maximale de 74 caractères.
    PROMPT

    chat = RubyLLM.chat(model: "gpt-4o").with_temperature(0.7)
    response = chat.ask(
      "Tu es un assistant bienveillant et expert en suivi d'habitudes.\n\n#{prompt}"
    )
    tip_text = response.content || "Aucun conseil généré."


    Tip.create!(
      habit: habit,
      user: habit.user,
      content: tip_text
    )
  end
end
