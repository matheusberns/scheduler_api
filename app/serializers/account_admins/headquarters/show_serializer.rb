# frozen_string_literal: true

module AccountAdmins::Headquarters
  class ShowSerializer < BaseSerializer
    attributes :cnpj,
               :name,
               :logo,
               :uuid,
               :campos_personalizados

    def cnpj
      ::CNPJ.new(object.cnpj).formatted
    end

    def logo
      return unless object.logo.attached?

      Rails.application.routes.url_helpers.rails_blob_path(object.logo,
                                                           only_path: true)
    end
  end
end