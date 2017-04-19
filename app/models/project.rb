class Project < ApplicationRecord
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
      return self.questionnaire_id.mb_chars.normalize(:kd).gsub(/[(-)]/,'').gsub(/[^\x00-\x7F]/n,'').downcase.gsub(/\s/,'_')
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
    score = {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]}
    count = 0
    values = []
    self.response_sus.each do |response|
      count += 1
      values.push(2.5 * (response.Q1 + response.Q2 + response.Q3 + response.Q4 + response.Q5 + response.Q6 + response.Q7 + response.Q8 + response.Q9 + response.Q10))
    end
    if count > 0
      score = compute_stats_summary_for_data(values, count)
    end
    return score
  end
  # (original)
  # def sus_score
  #   score = 0
  #   count = 0
  #   sum = 0
  #   self.response_sus.each do |response|
  #     count = count + 1
  #     sum = sum + (2.5 * (response.Q1 + response.Q2 + response.Q3 + response.Q4 + response.Q5 + response.Q6 + response.Q7 + response.Q8 + response.Q9 + response.Q10))
  #   end
  #   if count > 0
  #     score = sum / count
  #   end
  #   return score.round(2)
  # end

  def sus_grade
    score = self.sus_score[:mean]
    if score >= 84.1
      return "A+"
    elsif score >= 80.8
      return "A"
    elsif score >= 78.9
      return "A-"
    elsif score >= 77.2
      return "B+"
    elsif score >= 74.1
      return "B"
    elsif score >= 72.6
      return "B-"
    elsif score >= 71.1
      return "C+"
    elsif score >= 65
      return "C"
    elsif score >= 62.7
      return "C-"
    elsif score >= 51.7
      return "D"
    else
      return "F"
    end
  end

# Attrak Diff
  def attrakdiff_average_scores
    values = {
      QP:  [],
      QHS: [],
      QHI: [],
      ATT: [],
      QH: []
    }
    score = {
      QP:  {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      QHS: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      QHI: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      ATT: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      QH: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]}
    }
    count = 0
    abridged = false
    responses = self.response_attrak_diffs
    if self.questionnaire_id_clean == "attrakdiff_abrege"
      abridged = true
      responses = self.response_attrak_diff_abridgeds
    end
    responses.each do |response|
      count += 1
      if !abridged
        values[:QP].push(response.QP1, response.QP2, response.QP3, response.QP4, response.QP5, response.QP6, response.QP7)
        values[:QHS].push(response.QHS1, response.QHS2, response.QHS3, response.QHS4, response.QHS5, response.QHS6, response.QHS7)
        values[:QHI].push(response.QHI1, response.QHI2, response.QHI3, response.QHI4, response.QHI5, response.QHI6, response.QHI7)
        values[:ATT].push(response.ATT1, response.ATT2, response.ATT3, response.ATT4, response.ATT5, response.ATT6, response.ATT7)
        values[:QH].push(response.QHS1, response.QHS2, response.QHS3, response.QHS4, response.QHS5, response.QHS6, response.QHS7, response.QHI1, response.QHI2, response.QHI3, response.QHI4, response.QHI5, response.QHI6, response.QHI7)
      else
        values[:QP].push(response.QP2, response.QP3, response.QP5, response.QP6)
        values[:QHS].push(response.QHS2, response.QHS5)
        values[:QHI].push(response.QHI3, response.QHI4)
        values[:ATT].push(response.ATT2, response.ATT5)
        values[:QH].push(response.QHS2, response.QHS5, response.QHI3, response.QHI4)
      end
    end
    if count > 0
      score[:QP]  = compute_stats_summary_for_data(values[:QP], count)
      score[:QHS] = compute_stats_summary_for_data(values[:QHS], count)
      score[:QHI] = compute_stats_summary_for_data(values[:QHI], count)
      score[:ATT] = compute_stats_summary_for_data(values[:ATT], count)
      score[:QH]  = compute_stats_summary_for_data(values[:QH], count)
    end
    return score
  end

  def attrakdiff_word_pair_average_score
    score = {
      QP1:  0.00, QP2:  0.00, QP3:  0.00, QP4:  0.00, QP5:  0.00, QP6:  0.00, QP7:  0.00,
      QHS1: 0.00, QHS2: 0.00, QHS3: 0.00, QHS4: 0.00, QHS5: 0.00, QHS6: 0.00, QHS7: 0.00,
      QHI1: 0.00, QHI2: 0.00, QHI3: 0.00, QHI4: 0.00, QHI5: 0.00, QHI6: 0.00, QHI7: 0.00,
      ATT1: 0.00, ATT2: 0.00, ATT3: 0.00, ATT4: 0.00, ATT5: 0.00, ATT6: 0.00, ATT7: 0.00
    }
    count = 0
    sum = score
    abridged = false
    responses = self.response_attrak_diffs
    if self.questionnaire_id_clean == "attrakdiff_abrege"
      abridged = true
      responses = self.response_attrak_diff_abridgeds
    end
    responses.each do |response|
      count = count + 1
      sum[:QP1] = sum[:QP1] + response.QP1 if !abridged
      sum[:QP2] = sum[:QP2] + response.QP2
      sum[:QP3] = sum[:QP3] + response.QP3
      sum[:QP4] = sum[:QP4] + response.QP4 if !abridged
      sum[:QP5] = sum[:QP5] + response.QP5
      sum[:QP6] = sum[:QP6] + response.QP6
      sum[:QP7] = sum[:QP7] + response.QP7 if !abridged

      sum[:QHS1] = sum[:QHS1] + response.QHS1 if !abridged
      sum[:QHS2] = sum[:QHS2] + response.QHS2
      sum[:QHS3] = sum[:QHS3] + response.QHS3 if !abridged
      sum[:QHS4] = sum[:QHS4] + response.QHS4 if !abridged
      sum[:QHS5] = sum[:QHS5] + response.QHS5
      sum[:QHS6] = sum[:QHS6] + response.QHS6 if !abridged
      sum[:QHS7] = sum[:QHS7] + response.QHS7 if !abridged

      sum[:QHI1] = sum[:QHI1] + response.QHI1 if !abridged
      sum[:QHI2] = sum[:QHI2] + response.QHI2 if !abridged
      sum[:QHI3] = sum[:QHI3] + response.QHI3
      sum[:QHI4] = sum[:QHI4] + response.QHI4
      sum[:QHI5] = sum[:QHI5] + response.QHI5 if !abridged
      sum[:QHI6] = sum[:QHI6] + response.QHI6 if !abridged
      sum[:QHI7] = sum[:QHI7] + response.QHI7 if !abridged

      sum[:ATT1] = sum[:ATT1] + response.ATT1 if !abridged
      sum[:ATT2] = sum[:ATT2] + response.ATT2
      sum[:ATT3] = sum[:ATT3] + response.ATT3 if !abridged
      sum[:ATT4] = sum[:ATT4] + response.ATT4 if !abridged
      sum[:ATT5] = sum[:ATT5] + response.ATT5
      sum[:ATT6] = sum[:ATT6] + response.ATT6 if !abridged
      sum[:ATT7] = sum[:ATT7] + response.ATT7 if !abridged
    end
    if count > 0
      score[:QP1]  = (sum[:QP1]  / count).round(2)
      score[:QP2]  = (sum[:QP2]  / count).round(2)
      score[:QP3]  = (sum[:QP3]  / count).round(2)
      score[:QP4]  = (sum[:QP4]  / count).round(2)
      score[:QP5]  = (sum[:QP5]  / count).round(2)
      score[:QP6]  = (sum[:QP6]  / count).round(2)
      score[:QP7]  = (sum[:QP7]  / count).round(2)
      score[:QHS1] = (sum[:QHS1] / count).round(2)
      score[:QHS2] = (sum[:QHS2] / count).round(2)
      score[:QHS3] = (sum[:QHS3] / count).round(2)
      score[:QHS4] = (sum[:QHS4] / count).round(2)
      score[:QHS5] = (sum[:QHS5] / count).round(2)
      score[:QHS6] = (sum[:QHS6] / count).round(2)
      score[:QHS7] = (sum[:QHS7] / count).round(2)
      score[:QHI1] = (sum[:QHI1] / count).round(2)
      score[:QHI2] = (sum[:QHI2] / count).round(2)
      score[:QHI3] = (sum[:QHI3] / count).round(2)
      score[:QHI4] = (sum[:QHI4] / count).round(2)
      score[:QHI5] = (sum[:QHI5] / count).round(2)
      score[:QHI6] = (sum[:QHI6] / count).round(2)
      score[:QHI7] = (sum[:QHI7] / count).round(2)
      score[:ATT1] = (sum[:ATT1] / count).round(2)
      score[:ATT2] = (sum[:ATT2] / count).round(2)
      score[:ATT3] = (sum[:ATT3] / count).round(2)
      score[:ATT4] = (sum[:ATT4] / count).round(2)
      score[:ATT5] = (sum[:ATT5] / count).round(2)
      score[:ATT6] = (sum[:ATT6] / count).round(2)
      score[:ATT7] = (sum[:ATT7] / count).round(2)
    end
    return score
  end

# DEEP
  def deep_scores
    values = {
      G1: [],
      G2: [],
      G3: [],
      G4: [],
      G5: [],
      G6: []
    }
    score = {
      G1: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      G2: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      G3: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      G4: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      G5: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      G6: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]}
    }
    count = 0

    self.response_deeps.each do |response|
      count += 1
      values[:G1].push(response.Q1) if response.Q1 > 0 # on exclus les "0" car ils correspondent à la réponse "non applicable"
      values[:G1].push(response.Q2) if response.Q2 > 0
      values[:G1].push(response.Q3) if response.Q3 > 0
      values[:G1].push(response.Q4) if response.Q4 > 0
      values[:G2].push(response.Q5) if response.Q5 > 0
      values[:G2].push(response.Q6) if response.Q6 > 0
      values[:G2].push(response.Q7) if response.Q7 > 0
      values[:G3].push(response.Q8) if response.Q8 > 0
      values[:G3].push(response.Q9) if response.Q9 > 0
      values[:G3].push(response.Q10) if response.Q10 > 0
      values[:G4].push(response.Q11) if response.Q11 > 0
      values[:G4].push(response.Q12) if response.Q12 > 0
      values[:G4].push(response.Q13) if response.Q13 > 0
      values[:G5].push(response.Q14) if response.Q14 > 0
      values[:G5].push(response.Q15) if response.Q15 > 0
      values[:G5].push(response.Q16) if response.Q16 > 0
      values[:G6].push(response.Q17) if response.Q17 > 0
      values[:G6].push(response.Q18) if response.Q18 > 0
      values[:G6].push(response.Q19) if response.Q19 > 0
    end
    if count > 0
      score[:G1] = compute_stats_summary_for_data(values[:G1], count)
      score[:G2] = compute_stats_summary_for_data(values[:G2], count)
      score[:G3] = compute_stats_summary_for_data(values[:G3], count)
      score[:G4] = compute_stats_summary_for_data(values[:G4], count)
      score[:G5] = compute_stats_summary_for_data(values[:G5], count)
      score[:G6] = compute_stats_summary_for_data(values[:G6], count)
    end
    return score
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

  #
  # Calcule : moyenne, écart-type et intervalles de confiances (90%, 95%, 99%) pour un ensemble de données
  #
  def compute_stats_summary_for_data(data_array, n, round = 2)
    data_array.to_vector(:scale)
    summary = {
      mean:   0.00,
      sd:     0.00,
      ci_90: [0.00, 0.00],
      ci_95: [0.00, 0.00],
      ci_99: [0.00, 0.00]
    }
    summary[:mean]   = data_array.mean.round(round)
    summary[:sd]     = data_array.sd.round(round)
    if n > 60
      summary[:ci_90]= Statsample::SRS.mean_confidence_interval_z(data_array.mean, data_array.sd, n, 10**100, 0.9)
      summary[:ci_95]= Statsample::SRS.mean_confidence_interval_z(data_array.mean, data_array.sd, n, 10**100, 0.95)
      summary[:ci_99]= Statsample::SRS.mean_confidence_interval_z(data_array.mean, data_array.sd, n, 10**100, 0.99)
    else
      summary[:ci_90]= Statsample::SRS.mean_confidence_interval_t(data_array.mean, data_array.sd, n, 10**100, 0.9)
      summary[:ci_95]= Statsample::SRS.mean_confidence_interval_t(data_array.mean, data_array.sd, n, 10**100, 0.95)
      summary[:ci_99]= Statsample::SRS.mean_confidence_interval_t(data_array.mean, data_array.sd, n, 10**100, 0.99)
    end

    summary[:ci_90][0] = summary[:ci_90][0].round(round)
    summary[:ci_95][0] = summary[:ci_95][0].round(round)
    summary[:ci_99][0] = summary[:ci_99][0].round(round)
    summary[:ci_90][1] = summary[:ci_90][1].round(round)
    summary[:ci_95][1] = summary[:ci_95][1].round(round)
    summary[:ci_99][1] = summary[:ci_99][1].round(round)
    return summary
  end

end
