class Project < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  has_many :response_attrak_diffs, dependent: :destroy
  has_many :response_attrak_diff_abridgeds, dependent: :destroy
  has_many :response_sus, dependent: :destroy
  has_many :response_deeps, dependent: :destroy

  validates_presence_of :questionnaire_id, :questionnaire_language, :product_type, :product_name, :project_code

  before_create :add_token, :generate_instructions

  def self.questionnaireTypes
    [ResponseAttrakDiff::Infos[:display_name], ResponseAttrakDiffAbridged::Infos[:display_name], ResponseSu::Infos[:display_name], ResponseDeep::Infos[:display_name_short]]
    #[ResponseAttrakDiff::Infos[:display_name], ResponseSu::Infos[:display_name], ResponseDeep::Infos[:display_name_short]]
  end

  def self.questionnaireLanguages
    ["Français", "Anglais"]
  end

  def self.productTypes
    ["Site Web", "Site E-Commerce", "Application mobile", "Application tablette", "Logiciel", "Autre"]
  end

  def has_responses?
    if !self.responses.nil? && self.responses.count > 0
      return true
    else
      return false
    end
  end

  def questionnaire_id_clean
    if self.questionnaire_id.nil?
      return nil
    else
      return self.questionnaire_id.mb_chars.normalize(:kd).gsub(/[(-)]/,'').gsub(/[^\x00-\x7F]/,'').downcase.gsub(/\s/,'_')
    end
  end

  def questionnaire_language_code
    if self.questionnaire_language.nil?
      return nil
    else
      if self.questionnaire_language_clean == "anglais"
        return 'en'
      else
        return 'fr'
      end
    end
  end

  def questionnaire_language_clean
    if self.questionnaire_language.nil?
      return nil
    else
      return self.questionnaire_language.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase
    end
  end

  def questionnaire_template
    # Ex.: 'projects/questionnaires/system_usability_scale'
    return 'projects' + File::SEPARATOR + 'questionnaires' + File::SEPARATOR + self.questionnaire_id_clean
  end

  def responses
    if self.questionnaire_id_clean == "attrakdiff"
      return self.response_attrak_diffs
    elsif self.questionnaire_id_clean == "attrakdiff_abrege"
      return self.response_attrak_diff_abridgeds
    elsif self.questionnaire_id_clean == "system_usability_scale"
      return self.response_sus
    elsif self.questionnaire_id_clean == "deep"
      return self.response_deeps
    else
      return nil
    end
  end

  # Teste si le projet devrait avoir le statut "is_closed" d'après les dates
  def should_get_closed
    should_get_closed = false
    if !self.is_closed
      if !self.end_date.nil? && (self.end_date < Date.today)
        should_get_closed = true
      end
    end
    return should_get_closed
  end

  # System Usability Scale
  def sus_score
    return Stats::SUS::score(self.response_sus)
  end

  def sus_grade
    return Stats::SUS::grade(self.sus_score[:mean])
  end

  def sus_product_type
    case product_type
    when "Site Web"
      {:fr => "ce site web",
      :en => "this website"}
    when "Site E-Commerce"
      {:fr => "ce site e-commerce",
      :en => "this e-commerce website"}
    when "Application mobile"
      {:fr => "cette application mobile",
      :en => "this mobile app"}
    when "Application tablette"
      {:fr => "cette application tablette",
      :en => "this tablet app"}
    when "Logiciel"
      {:fr => "ce logiciel",
      :en => "this software"}
    else
      sus_default_product_type
    end
  end

  def sus_default_product_type
    {:fr => "ce système",
    :en => "this system"}
  end

  # Attrak Diff
  def attrakdiff_average_scores
    abridged = false
    if self.questionnaire_id_clean == "attrakdiff_abrege"
      abridged = true
    end
    return Stats::AttrakDiff::average_scores(self.responses, abridged)
  end

  def attrakdiff_word_pair_average_score
    abridged = false
    if self.questionnaire_id_clean == "attrakdiff_abrege"
      abridged = true
    end
    return Stats::AttrakDiff::word_pair_average_scores(self.responses, abridged)
  end

  # DEEP
  def deep_scores
    return Stats::Deep::average_scores(self.responses)
  end

  def generate_instructions
    instructions = ""
    product_name = self.product_name
    if self.questionnaire_id_clean == "attrakdiff"
      instructions = ResponseAttrakDiff::generate_instructions(self)
    elsif self.questionnaire_id_clean == "attrakdiff_abrege"
      instructions = ResponseAttrakDiffAbridged::generate_instructions(self)
    elsif self.questionnaire_id_clean == "system_usability_scale"
      instructions = ResponseSu::generate_instructions(self)
    elsif self.questionnaire_id_clean == "deep"
      instructions = ResponseDeep::generate_instructions(self)
    end
    self.instructions = instructions
  end

  private
  def add_token
    begin
      self.uri_token = SecureRandom.hex[0,20].upcase
    rescue ActiveRecord::RecordNotUnique
      retry
    end while self.class.exists?(uri_token: uri_token)
  end

end
