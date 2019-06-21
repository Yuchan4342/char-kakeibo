# frozen_string_literal: true

# Users module.
module Users
  # RegistrationsController
  class RegistrationsController < Devise::RegistrationsController
    include DefaultCategory
    after_action :create_default_category, only: [:create]

    # POST /users
    def create
      super
    end
  end
end
