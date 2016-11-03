class ResponseAttrakDiff < ApplicationRecord
  belongs_to :project

  validates_numericality_of :ATT1, :ATT2, :ATT3, :ATT4, :ATT5, :ATT6, :ATT7, :QP1, :QP2, :QP3, :QP4, :QP5, :QP6, :QP7, :QHS1, :QHS2, :QHS3, :QHS4, :QHS5, :QHS6, :QHS7, :QHI1, :QHI2, :QHI3, :QHI4, :QHI5, :QHI6, :QHI7, :only_integer => true, :greater_than_or_equal_to => -3, :less_than_or_equal_to => 3
  
  def self.to_csv
    attributes = %w{ATT1 ATT2 ATT3 ATT4 ATT5 ATT6 ATT7 QP1 QP2 QP3 QP4 QP5 QP6 QP7 QHS1 QHS2 QHS3 QHS4 QHS5 QHS6 QHS7 QHI1 QHI2 QHI3 QHI4 QHI5 QHI6 QHI7}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |response|
        csv << attributes.map{ |attr| response.send(attr) }
      end
    end
  end
end
