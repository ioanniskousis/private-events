class ApplicationController < ActionController::Base
  if Rails.env.test?

    def self.cash_session_user_id_for_testing(user_id)
      @session_user_id = user_id
    end

    def self.session_user_id_for_testing
      @session_user_id
    end
  end
end
