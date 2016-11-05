class Project < ApplicationRecord
  belongs_to :user

  has_many :response_attrak_diffs, :dependent => :delete_all
  has_many :response_sus, :dependent => :delete_all

  validates_presence_of :questionnaire_id, :questionnaire_language, :product_type, :product_name, :project_code, :end_date

  before_create :add_token

  def self.questionnaireTypes
    ["AttrakDiff", "System Usability Scale"]
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

  def questionnaire_language_clean
    if self.questionnaire_language.nil?
      return nil
    else
      return self.questionnaire_language.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase
    end
  end

  def questionnaire_template
    # Ex.: 'questionnaires/system_usability_scale/francais'
    return 'questionnaires' + File::SEPARATOR + self.questionnaire_id_clean + File::SEPARATOR + self.questionnaire_language_clean
  end

  def responses
    if self.questionnaire_id_clean == "attrakdiff"
      return self.response_attrak_diffs
    elsif self.questionnaire_id_clean == "system_usability_scale"
      return self.response_sus
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
      sum[:QHI] = sum[:QHS] + (response.QHI1 + response.QHI2 + response.QHI3 + response.QHI4 + response.QHI5 + response.QHI6 + response.QHI7)
      sum[:ATT] = sum[:QHS] + (response.ATT1 + response.ATT2 + response.ATT3 + response.ATT4 + response.ATT5 + response.ATT6 + response.ATT7)
    end
    if count > 0
      score[:QP]  = (sum[:QP]  / (7 * count)).round(2)
      score[:QHS] = (sum[:QHS] / (7 * count)).round(2)
      score[:QHI] = (sum[:QHI] / (7 * count)).round(2)
      score[:ATT] = (sum[:ATT] / (7 * count)).round(2)
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

  private
  def add_token
    begin
      self.uri_token = SecureRandom.hex[0,20].upcase
    rescue ActiveRecord::RecordNotUnique
      retry
    end while self.class.exists?(uri_token: uri_token)
  end
end
