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
    return self.questionnaire_id.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.gsub!(/\s/,'_')
  end

  def questionnaire_language_clean
    return self.questionnaire_language.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase
  end

  def questionnaire_template
    # Ex.: 'questionnaires/system_usability_scale/francais'
    return 'questionnaires' + File::SEPARATOR + self.questionnaire_id_clean + File::SEPARATOR + self.questionnaire_language_clean
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
