class Result {
  constructor(id, goalId, status, date) {
    this.id = id;
    this.goalId = goalId;
    this.status = status;
    this.date = date;

    if (store.results.filter(result => result.id === this.id).length === 0) {
      store.results.push(this);
    }
  }
}
