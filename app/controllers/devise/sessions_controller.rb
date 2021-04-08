class Devise::SessionsController < DeviseController
  prepend_before_action :allow_params_authentication!, only: :create
  # DELETE /resource/sign_out
  
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  def create
    
    self.resource = warden.authenticate!(auth_options)
   
    set_flash_message!(:notice, :signed_in)
   
    sign_in(resource_name, resource)
    yield resource if block_given?
   
    respond_with resource, location: after_sign_in_path_for(resource_name)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy(resource_name)
  end

  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  def translation_scope
    'devise.sessions'
  end



  private


  def respond_to_on_destroy(resource_name)
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end
end