module CommonHelpers
  def clean_params
    ActionController::Parameters.new(params)
  end
end
