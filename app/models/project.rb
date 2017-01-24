class Project < ApplicationRecord
  belongs_to :user

  has_many :response_attrak_diffs, dependent: :destroy
  has_many :response_sus, dependent: :destroy
  has_many :response_deeps, dependent: :destroy

  validates_presence_of :questionnaire_id, :questionnaire_language, :product_type, :product_name, :project_code, :end_date

  before_create :add_token, :generate_instructions

  def self.questionnaireTypes
    [ResponseAttrakDiff::Infos[:display_name], ResponseSu::Infos[:display_name], ResponseDeep::Infos[:display_name_short]]
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
      return self.questionnaire_id.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.gsub(/\s/,'_')
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
    elsif self.questionnaire_id_clean == "system_usability_scale"
      return self.response_sus
    elsif self.questionnaire_id_clean == "deep"
      return self.response_deeps
    else
      return nil
    end
  end

# System Usability Scale
  def sus_score
    score = 0
    count = 0
    sum = 0
    self.response_sus.each do |response|
      count = count + 1
      sum = sum + (2.5 * (response.Q1 + response.Q2 + response.Q3 + response.Q4 + response.Q5 + response.Q6 + response.Q7 + response.Q8 + response.Q9 + response.Q10))
    end
    if count > 0
      score = sum / count
    end
    return score.round(2)
  end

  def sus_grade
    score = self.sus_score
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

  # A supprimer car remplacé par "attrakdiff_average_scores"
  def attrakdiff_average_score
    score = {
      QP: 0.00,
      QHS: 0.00,
      QHI: 0.00,
      ATT: 0.00
    }
    count = 0
    sum = score
    self.response_attrak_diffs.each do |response|
      count = count + 1
      sum[:QP]  = sum[:QP]  + (response.QP1  + response.QP2  + response.QP3  + response.QP4  + response.QP5  + response.QP6  + response.QP7)
      sum[:QHS] = sum[:QHS] + (response.QHS1 + response.QHS2 + response.QHS3 + response.QHS4 + response.QHS5 + response.QHS6 + response.QHS7)
      sum[:QHI] = sum[:QHI] + (response.QHI1 + response.QHI2 + response.QHI3 + response.QHI4 + response.QHI5 + response.QHI6 + response.QHI7)
      sum[:ATT] = sum[:ATT] + (response.ATT1 + response.ATT2 + response.ATT3 + response.ATT4 + response.ATT5 + response.ATT6 + response.ATT7)
    end
    if count > 0
      score[:QP]  = (sum[:QP]  / (7 * count)).round(2)
      score[:QHS] = (sum[:QHS] / (7 * count)).round(2)
      score[:QHI] = (sum[:QHI] / (7 * count)).round(2)
      score[:ATT] = (sum[:ATT] / (7 * count)).round(2)
    end
    return score
  end

  def attrakdiff_average_scores
    values = {
      QP:  [],
      QHS: [],
      QHI: [],
      ATT: []
    }
    score = {
      QP:  {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      QHS: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      QHI: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]},
      ATT: {mean: 0.00, sd: 0.00, ci_90: [0.00, 0.00], ci_95: [0.00, 0.00], ci_99: [0.00, 0.00]}
    }
    count = 0
    self.response_attrak_diffs.each do |response|
      count += 1
      values[:QP].push(response.QP1, response.QP2, response.QP3, response.QP4, response.QP5, response.QP6, response.QP7)
      values[:QHS].push(response.QHS1, response.QHS2, response.QHS3, response.QHS4, response.QHS5, response.QHS6, response.QHS7)
      values[:QHI].push(response.QHI1, response.QHI2, response.QHI3, response.QHI4, response.QHI5, response.QHI6, response.QHI7)
      values[:ATT].push(response.ATT1, response.ATT2, response.ATT3, response.ATT4, response.ATT5, response.ATT6, response.ATT7)
    end
    if count > 0
      score[:QP] = compute_stats_summary_for_data(values[:QP], count)
      score[:QHS] = compute_stats_summary_for_data(values[:QHS], count)
      score[:QHI] = compute_stats_summary_for_data(values[:QHI], count)
      score[:ATT] = compute_stats_summary_for_data(values[:ATT], count)
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
    self.response_attrak_diffs.each do |response|
      count = count + 1
      sum[:QP1] = sum[:QP1] + response.QP1
      sum[:QP2] = sum[:QP2] + response.QP2
      sum[:QP3] = sum[:QP3] + response.QP3
      sum[:QP4] = sum[:QP4] + response.QP4
      sum[:QP5] = sum[:QP5] + response.QP5
      sum[:QP6] = sum[:QP6] + response.QP6
      sum[:QP7] = sum[:QP7] + response.QP7

      sum[:QHS1] = sum[:QHS1] + response.QHS1
      sum[:QHS2] = sum[:QHS2] + response.QHS2
      sum[:QHS3] = sum[:QHS3] + response.QHS3
      sum[:QHS4] = sum[:QHS4] + response.QHS4
      sum[:QHS5] = sum[:QHS5] + response.QHS5
      sum[:QHS6] = sum[:QHS6] + response.QHS6
      sum[:QHS7] = sum[:QHS7] + response.QHS7

      sum[:QHI1] = sum[:QHI1] + response.QHI1
      sum[:QHI2] = sum[:QHI2] + response.QHI2
      sum[:QHI3] = sum[:QHI3] + response.QHI3
      sum[:QHI4] = sum[:QHI4] + response.QHI4
      sum[:QHI5] = sum[:QHI5] + response.QHI5
      sum[:QHI6] = sum[:QHI6] + response.QHI6
      sum[:QHI7] = sum[:QHI7] + response.QHI7

      sum[:ATT1] = sum[:ATT1] + response.ATT1
      sum[:ATT2] = sum[:ATT2] + response.ATT2
      sum[:ATT3] = sum[:ATT3] + response.ATT3
      sum[:ATT4] = sum[:ATT4] + response.ATT4
      sum[:ATT5] = sum[:ATT5] + response.ATT5
      sum[:ATT6] = sum[:ATT6] + response.ATT6
      sum[:ATT7] = sum[:ATT7] + response.ATT7
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
    score = {
      G1: 0.00,
      G2: 0.00,
      G3: 0.00,
      G4: 0.00,
      G5: 0.00,
      G6: 0.00
    }
    dividers = {
      G1: 0,
      G2: 0,
      G3: 0,
      G4: 0,
      G5: 0,
      G6: 0
    }
    count = 0
    sum = score

    self.response_deeps.each do |response|
      count += 1
      dividers[:G1] += 1 if response.Q1 > 0
      dividers[:G1] += 1 if response.Q2 > 0
      dividers[:G1] += 1 if response.Q3 > 0
      dividers[:G1] += 1 if response.Q4 > 0
      dividers[:G2] += 1 if response.Q5 > 0
      dividers[:G2] += 1 if response.Q6 > 0
      dividers[:G2] += 1 if response.Q7 > 0
      dividers[:G3] += 1 if response.Q8 > 0
      dividers[:G3] += 1 if response.Q9 > 0
      dividers[:G3] += 1 if response.Q10 > 0
      dividers[:G4] += 1 if response.Q11 > 0
      dividers[:G4] += 1 if response.Q12 > 0
      dividers[:G4] += 1 if response.Q13 > 0
      dividers[:G5] += 1 if response.Q14 > 0
      dividers[:G5] += 1 if response.Q15 > 0
      dividers[:G5] += 1 if response.Q16 > 0
      dividers[:G6] += 1 if response.Q17 > 0
      dividers[:G6] += 1 if response.Q18 > 0
      dividers[:G6] += 1 if response.Q19 > 0

      sum[:G1]  = sum[:G1]  + (response.Q1  + response.Q2  + response.Q3  + response.Q4)
      sum[:G2]  = sum[:G2]  + (response.Q5  + response.Q6  + response.Q7)
      sum[:G3]  = sum[:G3]  + (response.Q8  + response.Q9  + response.Q10)
      sum[:G4]  = sum[:G4]  + (response.Q11  + response.Q12  + response.Q13)
      sum[:G5]  = sum[:G5]  + (response.Q14  + response.Q15  + response.Q16)
      sum[:G6]  = sum[:G6]  + (response.Q17  + response.Q18  + response.Q19)
    end
    if count > 0
      score[:G1]  = (sum[:G1]  / dividers[:G1]).round(2)
      score[:G2]  = (sum[:G2]  / dividers[:G2]).round(2)
      score[:G3]  = (sum[:G3]  / dividers[:G3]).round(2)
      score[:G4]  = (sum[:G4]  / dividers[:G4]).round(2)
      score[:G5]  = (sum[:G5]  / dividers[:G5]).round(2)
      score[:G6]  = (sum[:G6]  / dividers[:G6]).round(2)
      puts score
    end
    return score
  end

  def generate_instructions
    instructions = ""
    product_name = self.product_name
    if self.questionnaire_id_clean == "attrakdiff"
      instructions = ResponseAttrakDiff::generate_instructions(self)
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
