# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @q = current_user.bulletins.ransack(params[:q])

    @bulletins = @q.result(distinct: true)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(20)

    @aasm_options = aasm_options
  end

  def create
    current_user.update(admin: true)
    redirect_to profile_path, notice: t('flash.profiles.make_admin.success')
  end

  def destroy
    current_user.update(admin: false)
    redirect_to profile_path, notice: t('flash.profiles.remove_admin.success')
  end

  private

  def aasm_options
    Bulletin.aasm.states.map do |state|
      [I18n.t("aasm.state.bulletin.#{state.name}"), state.name.to_s]
    end
  end
end
