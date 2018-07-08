class Goal {
  constructor(id, description, startDate, endDate, interval, priority, userId) {
    this.id = id;
    this.description = description;
    this.startDate = startDate;
    this.endDate = endDate;
    this.interval = interval;
    this.priority = priority;
    this.userId = userId;

    if (store.goals.filter(goal => goal.id === this.id).length === 0) {
      store.goals.push(this);
    }
  }

  generateDateRange() {
    let start = moment(this.startDate)
    let end = moment(this.endDate)
    let date_range = moment().range(start, end)
    console.log(date_range)
    if (this.interval === "daily") {
      //daily logic
    } else if (this.interval === "weekly") {
      //weekly logic
    } else {
      //monthly logic
    }
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
