class UserMailerPreview < ActionMailer::Preview

    def account_verificaton
        user = User.last
        user.verification_token = User.new_token
        UserMailer.account_verification(user)
    end

    def password_reset
        user = User.last
        user.reset_token = User.new_token
        UserMailer.password_reset(user)
    end

end