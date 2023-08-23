# frozen_string_literal: true

class IntegrationTypeEnum < EnumerateIt::Base
  associate_values(
    web: 1,
    app: 2
  )

  sort_by :value
end
