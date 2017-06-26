# Module to override defualt error messages of devise!
module DeviseHelper
  def devise_error_messages!
    'EPIC ERROR MESSAGE!'
  end
end