# frozen_string_literal: true

class ScheduleSituationEnum < EnumerateIt::Base
  associate_values(
    confirmed: 1,
    pending: 2,
    canceled: 3
  )

  sort_by :value
end
