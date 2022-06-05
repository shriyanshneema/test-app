module ApplicationHelper
  include Pagy::Frontend

  def errors(object)
    object.errors.full_messages
  end
end
