# frozen_string_literal: true

module AccountAdmins::Headquarters
  class IndexSerializer < BaseSerializer
    attributes :cnpj,
               :name,
               :campos_personalizados

    def cnpj
      ::CNPJ.new(object.cnpj).formatted
    end
  end
end
