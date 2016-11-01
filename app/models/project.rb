class Project < ApplicationRecord
  belongs_to :user

  has_many :response_attrak_diffs
  has_many :response_sus

  before_create :add_token

  def self.questionnaireTypes
    ["AttrakDiff", "System Usability Scale"]
  end

  def self.questionnaireLanguages
    ["Français", "Anglais"]
  end

  def self.productTypes
    ["Site Web", "Site E-Commerce", "Application mobile", "Application tablette", "Logiciel"]
  end

  def questionnaire_id_clean
    return self.questionnaire_id.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.gsub(/\s/,'_')
  end

  def questionnaire_language_clean
    return self.questionnaire_language.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase
  end

  def questionnaire_template
    # Ex.: 'questionnaires/system_usability_scale/francais'
    return 'questionnaires' + File::SEPARATOR + self.questionnaire_id_clean + File::SEPARATOR + self.questionnaire_language_clean
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
    if score === 0
      return "-"
    elsif score >= 78.9
      return "A"
    elsif score >= 72.6
      return "B"
    elsif score >= 62.7
      return "C"
    elsif score >= 51.7
      return "D"
    else
      return "F"
    end
  end

# Attrak Diff
  def attrakdiff_average_score
    score = {
      QP: 0,
      QHS: 0,
      QHI: 0,
      ATT: 0
    }
    count = 0
    sum = {
      QP: 0,
      QHS: 0,
      QHI: 0,
      ATT: 0
    }
    self.response_attrak_diffs.each do |response|
      count = count + 1
      sum[:QP]  = sum[:QP]  + (response.QP1  + response.QP2  + response.QP3  + response.QP4  + response.QP5  + response.QP6  + response.QP7)  / 7
      sum[:QHS] = sum[:QHS] + (response.QHS1 + response.QHS2 + response.QHS3 + response.QHS4 + response.QHS5 + response.QHS6 + response.QHS7) / 7
      sum[:QHI] = sum[:QHS] + (response.QHI1 + response.QHI2 + response.QHI3 + response.QHI4 + response.QHI5 + response.QHI6 + response.QHI7) / 7
      sum[:ATT] = sum[:QHS] + (response.ATT1 + response.ATT2 + response.ATT3 + response.ATT4 + response.ATT5 + response.ATT6 + response.ATT7) / 7
    end
    if count > 0
      score[:QP] = (sum[:QP] / count).round(2)
      score[:QHS] = (sum[:QHS] / count).round(2)
      score[:QHI] = (sum[:QHI] / count).round(2)
      score[:ATT] = (sum[:ATT] / count).round(2)
    end
    return score
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
