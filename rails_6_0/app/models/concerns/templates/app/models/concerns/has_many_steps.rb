module HasManySteps

  extend ActiveSupport::Concern

  included do
    attr_writer :current_step
  end

  def current_step
    @current_step || steps.first
  end

  def previous_steps
    steps[0, steps.index(current_step)]
  end

  def steps
    %i[]
  end

  def next_step
    self.current_step = steps[get_step(current_step, forward: true)]
  end

  def previous_step
    self.current_step = steps[get_step(current_step, forward: false)]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def get_step(current_step, forward: true)
    direction = forward ? 1 : -1
    if steps.index(current_step)
      steps.index(current_step) + direction
    else
      0
    end
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def step?(index)
    steps[index] == current_step
  end

end
