# frozen_string_literal: true

module Api::V1
  class HealthCheckController < ApplicationController
    before_action :authenticate_user!

    def index
      head :ok
    end
  end
end
