class Result {
  constructor(date, status, goalId) {
    this.date = date;
    this.status = status;
    this.goalId = goalId;

    store.results.push(this);
  }
}
