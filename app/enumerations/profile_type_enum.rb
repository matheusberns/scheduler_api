# frozen_string_literal: true

class ProfileTypeEnum < EnumerateIt::Base
  associate_values(
    professional: 1,
    customer: 2
  )

  sort_by :value
end
