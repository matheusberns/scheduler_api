# frozen_string_literal: true

module AccountAdmins::Accounts::Headquarters
  class IndexSerializer < BaseSerializer
    attributes :uuid,
               :campos_personalizados
  end
end
