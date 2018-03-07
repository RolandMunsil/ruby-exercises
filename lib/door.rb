require "aasm"

def make_lock(type)
  aasm "#{type}_lock".to_sym, namespace: "#{type}".to_sym do
    state :unlocked, initial: true
    state :locked

    event "lock_#{type}".to_sym do
      transitions to: :locked
    end

    event "unlock_#{type}".to_sym do
      transitions to: :unlocked
    end
  end
end

class Door
  include AASM

  aasm do
    state :closed, initial: true
    state :open

    event :open do
      transitions to: :open, if: [:deadbolt_unlocked?, :knob_unlocked?]
    end

    event :close do
      transitions to: :closed, if: :deadbolt_unlocked?
    end
  end

  make_lock("deadbolt")
  make_lock("knob")
end
