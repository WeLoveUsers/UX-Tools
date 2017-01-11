class GenerateInstructionsForProjects < ActiveRecord::Migration[5.0]
  def up
    Project.all.each do |p|
      p.generate_instructions
      p.save
    end
  end
end
