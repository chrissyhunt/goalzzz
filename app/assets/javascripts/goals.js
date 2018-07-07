class Goal {
  constructor(description, startDate, endDate, interval, priority, userId) {
    this.description = description;
    this.startDate = startDate;
    this.endDate = endDate;
    this.interval = interval;
    this.priority = priority;
    this.userId = userId;

    store.goals.push(this);
  }

  percentComplete() {
    // build from Goal model method
  }

  getResultsByDate() {
    // AJAX request to Ruby method
  }

  getReflectionsByDate() {
    // AJAX request to Ruby method
  }

  getSuccessRate() {
    // AJAX request to Ruby method
  }

  getCurrentSuccessStreak() {
    // AJAX request to Ruby method
  }

  getLongestStreak() {
    // AJAX request to Ruby method
  }
}
