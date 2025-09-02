class LlmService
  def self.generate_tips(prompt)
    chat = RubyLLM.chat(model: "gpt-4o")
    response = chat.ask(prompt)
    response.content || "Pas de tips générés."
  end
end
