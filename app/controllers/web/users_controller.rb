class Web::UsersController < Web::ApplicationController
  before_action :authenticate_user!

  def profile
    @bulletins = current_user.bulletins.where(state: [ :draft, :published, :rejected ])
  end
end
