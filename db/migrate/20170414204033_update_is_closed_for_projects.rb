class UpdateIsClosedForProjects < ActiveRecord::Migration[5.0]
  def up
    Project.all.each do |p|
      if p.should_get_closed
        p.is_closed = true
        p.save
      end
    end
  end
end
