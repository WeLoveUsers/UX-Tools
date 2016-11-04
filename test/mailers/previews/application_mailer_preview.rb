class ApplicationMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    ApplicationMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def reset_password_instructions
    ApplicationMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    ApplicationMailer.unlock_instructions(User.first, "faketoken", {})
  end
end
