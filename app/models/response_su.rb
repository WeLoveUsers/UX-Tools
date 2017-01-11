class ResponseSu < ApplicationRecord
  belongs_to :project

  validates_numericality_of :Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 4

  Infos = {
    :id => "sus",
    :display_name => "System Usability Scale",
    :display_name_short => "SUS",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 10,
    :description => "<p>Mesure de <strong>l’utilisabilité</strong> d'un <strong>système</strong>.</p><p>Le questionnaire peut également fournir une mesure de l'apprentissage (<em>learnability</em>).<p>",
    :bibliography => ['Bangor, A., Kortum, P., & Miller, J. (2009). Determining what individual SUS scores mean: Adding an adjective rating scale. <em>Journal of usability studies, 4</em>(3), 114-123.']
  }

  Export_entete = ["Répondant", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Date et heure"]

  Q1_label  = {:fr => "Je pense que j'aimerais utiliser ce système fréquemment.",
               :en => "I think that I would like to use this system frequently."}
  Q2_label  = {:fr => "J'ai trouvé ce système inutilement complexe.",
               :en => "I found the system unnecessarily complex."}
  Q3_label  = {:fr => "J'ai trouvé ce système facile à utiliser.",
               :en => "I thought the system was easy to use."}
  Q4_label  = {:fr => "Je pense que j'aurais besoin d'un support technique pour être capable d'utiliser ce système.",
               :en => "I think that I would need the support of a technical person to be able to use this system."}
  Q5_label  = {:fr => "J'ai trouvé que les différentes fonctions de ce système étaient bien intégrées.",
               :en => "I found the various functions in this system were well integrated."}
  Q6_label  = {:fr => "J'ai trouvé qu'il y avait trop d'incohérence dans ce système.",
               :en => "I thought there was too much inconsistency in this system."}
  Q7_label  = {:fr => "Je suppose que la plupart des gens apprendraient très rapidement à utiliser ce système.",
               :en => "I would imagine that most people would learn to use this system very quickly."}
  Q8_label  = {:fr => "J'ai trouvé ce système très contraignant à utiliser.",
               :en => "I found the system very cumbersome to use."}
  Q9_label  = {:fr => "Je me suis senti(e) très confiant(e) en utilisant ce système.",
               :en => "I felt very confident using the system."}
  Q10_label = {:fr => "J'ai du apprendre beaucoup de choses avant de me sentir familiarisé(e) avec ce système.",
               :en => "I needed to learn a lot of things before I could get going with this system."}

  def self.generate_instructions(project)
    instructions = ""
    product_name = project.product_name
    if project.questionnaire_language_clean == "francais"
      instructions = <<-HTML
        <div>Nous souhaitons évaluer de la facilité d'utilisation de <strong>#{product_name}</strong>.</div>
        <div>Des affirmations vont vous être présentées. Veuillez donner votre degré d'accord avec celles-ci (de "pas du tout d'accord" à "tout à fait d'accord").</div>
      HTML
      instructions.html_safe
    elsif project.questionnaire_language_clean == "anglais"
      instructions = <<-HTML
        <div>For each of the following statements, choose what best describes your reactions towards <strong>#{product_name}</strong>.</div>
      HTML
      instructions.html_safe
    end
    return instructions
  end

  # def self.to_csv
  #   attributes = ResponseSu::Export_entete
  #
  #   CSV.generate(headers: true) do |csv|
  #     csv << attributes
  #
  #     i = 1
  #     all.each do |response|
  #       csv << attributes.map{ |attr| response.send(attr) }
  #       i = i + 1
  #     end
  #   end
  # end
end
