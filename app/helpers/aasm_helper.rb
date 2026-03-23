module AasmHelper
  def human_state(state_name, model_class = Bulletin)
    I18n.t("aasm.state.#{model_class.name.underscore}.#{state_name}",
           default: state_name.to_s.humanize)
  end
end
