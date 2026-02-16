class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  include Pundit::Authorization

  def index
    @bulletins = Bulletin.all
    authorize @bulletins
  end
end
