class ResponseSu < ApplicationRecord
  belongs_to :project

  validates_numericality_of :Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 4

  def self.to_csv
    attributes = %w{Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9 Q10}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |response|
        csv << attributes.map{ |attr| response.send(attr) }
      end
    end
  end
end
