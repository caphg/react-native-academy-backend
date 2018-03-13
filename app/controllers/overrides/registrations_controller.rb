module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    def render_create_success
      create_token
      render json: {
        data: resource_data(
          resource_json: @resource
        )
      }
    end

    private

    def create_token
      client_id = SecureRandom.urlsafe_base64(nil, false)
      token = SecureRandom.urlsafe_base64(nil, false)

      @resource.tokens[client_id] = {
        token: BCrypt::Password.create(token),
        expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }

      new_auth_header = @resource.build_auth_header(token, client_id)
      response.headers.merge!(new_auth_header)
    end
  end
end
