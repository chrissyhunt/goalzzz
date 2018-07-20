// ALL GOALS

function setGoalsEventListeners() {
  $('a').on('click', function(e) {
    e.preventDefault();
    getGoalResults(e.target);
  })
}

function setNewGoalEventListeners() {
  $('#new_goal').on("submit", function(e) {
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize()
    }).done(function(response) {
      let goal = new Goal(response.id, response.description, response.start_date, response.end_date, response.interval, response.priority, response.user_id);
      addNewGoalToList(goal);
      $('#new_goal')[0].reset();
    })
  })
}

// GOAL SHOW

function setGoalNavLinkEventListeners() {
  $('a#prevgoal').on('click', function(e) {
    e.preventDefault();
    getGoalResults(e.target);
  });
  $('a#nextgoal').on('click', function(e) {
    e.preventDefault();
    getGoalResults(e.target);
  });
}

function setGoalDeleteEventListeners() {
  $('a#delete').on('click', function(e) {
    e.preventDefault();
    deleteGoal(e.target.dataset.goalId);
  })
}

function setResultBoxEventListeners() {
  $('div.box').on('click', function(e) {
    if (e.target.dataset.id) {
      updateResult(e.target);
    } else {
      createResult(e.target);
    }
  })
}

function setReloadGoalsEventListeners() {
  $('a#reloadGoals').on('click', function() {
    reloadGoals();
  })
}
