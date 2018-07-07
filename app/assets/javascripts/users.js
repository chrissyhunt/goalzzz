class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;

    store.users.push(this);
  }

  getAverageSuccessRate() {
    // AJAX request to get info from Ruby method
  }

  getPersonalLongestStreak() {
    // AJAX request to get info from Ruby method
  }
}
