// GOAL INDEX DISPLAY FUNCTIONS

function getAllGoals() {
  $.ajax({
    method: 'GET',
    url: '/goals',
    contentType: 'application/json'
  }).done(function(response) {
    response.forEach(obj => {
      new Goal(obj.id, obj.description, obj.start_date, obj.end_date, obj.interval, obj.priority, obj.user_id);
    })
    loadAllGoals();
  })
}

function loadAllGoals() {
  let html = '<div class="col-12 main">'
  html += '<h1>All Goals</h1>'
  html += '<div class="row">'
  html += formatGoalsByPriority("high")
  html += formatGoalsByPriority("medium")
  html += formatGoalsByPriority("low")
  html += '</div></div>'
  $('div#content').append(html)
  setGoalsEventListeners();
}

function formatGoalsByPriority(priority) {
  let goalsHTML = '<div class="col-4">'
  goalsHTML += `<h4>${priority} PRIORITY</h4>`
  let priorityGoals = store.goals.filter(goal => {
    return goal.priority === priority
  })
  if (priorityGoals.length > 0) {
    priorityGoals.forEach(goal => {
      goalsHTML += `<a href="#" data-id="${goal.id}">${goal.description}</a><br />`
      goalsHTML += `<span class="end-date">${goal.interval.toUpperCase()}&nbsp;&middot;&nbsp;THROUGH ${moment(goal.endDate).format('M/D/YYYY').toUpperCase()}</span><br />`
    })
  } else {
    goalsHTML += '(None.)<br />'
  }
  return goalsHTML += '</div>'
}

// GOAL SHOW DISPLAY FUNCTIONS

function getGoalResults(goal) {
  console.log('load goal triggered, ID: ', goal.dataset.id);
  $.ajax({
    method: 'GET',
    url: `/goals/${goal.dataset.id}.json`,
    contentType: 'application/json'
  }).done(function(response) {
    response.results.forEach(obj => {
      new Result(obj.id, obj.goal_id, obj.status, obj.date);
      obj.reflections.forEach(refl => {
        new Reflection(refl.id, refl.content, refl.result_id);
      })
    })
    loadGoalResults(goal.dataset.id);
  })
}

function loadGoalResults(goalId) {
  let goal = store.goals.filter(goal => goal.id == goalId)[0];
  clearContent();
  let html = '<div class="row"><div class="col-12 main">'
  html += `<h1>${goal.description}</h1>`
  html += `<p>(Stats will go here.)</p>`
  html += '<div class="row">'
  html += generateResultsDisplay(goal);
  html += '</div></div></div>'
  html += '<div class="row"><div class="col-12 secondary">'
  html += '<h3>Your Thoughts So Far</h3>'
  html += generateReflectionsDisplay(goal);
  // build out Reflections display, call generateReflectionsDisplay(goal)
  $('div#content').append(html);
  setGoalNavLinkEventListeners();
}

function generateReflectionsDisplay(goal) {
  console.log('generateReflectionsDisplay triggered');
  let reflections = store.reflections.map(function(refl) {
    let result = store.results.filter(result => result.id === refl.resultId)[0]
    refl.date = result.date;
    refl.status = result.status;
    return refl;
  }).sort(function(a, b) {
    return a.date - b.date;
  })

  let html = '';
  reflections.forEach(refl => {
    let success = '';
    if (refl.status === 'success') {
      success = '-success'
    }
    html += '<div class="row"><div class="col-2">'
    html += `${moment(refl.date).format('M/D/YYYY')}`
    html += `</div><div class="col-10 notes-col${success}">`
    html += `${refl.content}`
    html += '</div></div>'
  })
  html += `<p class="menu"><a href="#" id="prevgoal" data-id="${goal.id}"><< PREV</a> &nbsp;&nbsp;&nbsp; <a href="#" id="nextgoal" data-id="${goal.id}">NEXT >></a></p>`
  return html;
}

function generateResultsDisplay(goal) {
  if (goal.interval == "daily") {
    return generateDailyResultsDisplay(goal);
  } else if (goal.interval == "weekly") {
    return generateWeeklyResultsDisplay(goal);
  } else {
    return generateMonthlyResultsDisplay(goal);
  }
}

function generateDailyResultsDisplay(goal) {
  let goalDatesArray = goal.generateDateRange();
  let html = '';
  // Using generated array of dates (needed to build display) to check for matching results
  goalDatesArray.forEach(date => {
    let result = store.results.filter(result => result.date === date.format('YYYY-MM-DD'))[0]
    let resultClass;
    if (result) {
      if (result.status == "success") {
        resultClass="green"
      } else {
        resultClass="red"
      }
    } else {
      resultClass = "blank"
    }
    html += `<div class="col-1 ${resultClass}-result box">`
    html += `${date.format('M/D')}`
    html += '</div>'
  })
  return html;
}

function generateWeeklyResultsDisplay(goal) {
  let goalDatesArray = goal.generateDateRange();
  let html = '';
  goalDatesArray.forEach(date => {
    let currentDate = date.format('YYYY-MM-DD');
    let endOfWeek = date.clone().add(6, 'days').format('YYYY-MM-DD');
    let resultsInWeek = store.results.filter(result => moment(result.date).isBetween(currentDate, endOfWeek, null, '[]'));
    let successesInWeek = resultsInWeek.filter(result => result['status'] == "success");
    let resultClass = "blank";
    // select for (1) first success, OR (2) first overall result
    if (successesInWeek.length > 0) {
      resultClass = "green";
      //eventually add link val -> first success in here?
    } else if (resultsInWeek.length > 0) {
      resultClass = "red";
      //eventually add link val -> first result in here?
    };
    html += `<div class="col-1 ${resultClass}-result box">`;
    html += `${date.format('M/D')}`;
    html += '</div>';
  });
  return html;
}

function generateMonthlyResultsDisplay(goal) {
  let goalDatesArray = goal.generateDateRange();
  let html = '';
  // Using generated array of dates (needed to build display) to check for matching results
  goalDatesArray.forEach(date => {
    let resultsInMonth = store.results.filter(result => moment(result.date).format('MM') === date.format('MM'));
    let successesInMonth = resultsInMonth.filter(result => result['status'] == "success");
    let resultClass = "blank";
    // select for (1) first success, OR (2) first overall result
    if (successesInMonth.length > 0) {
      resultClass = "green";
      //eventually add link val -> first success in here?
    } else if (resultsInMonth.length > 0) {
      resultClass = "red";
      //eventually add link val -> first result in here?
    };
    html += `<div class="col-1 ${resultClass}-result box">`;
    html += `${date.format('MMM')}`;
    html += '</div>';
  })
  return html;
}

// EVENT LISTENERS

function setGoalsEventListeners() {
  $('a').on('click', function(e) {
    e.preventDefault();
    getGoalResults(e.target);
  })
}

function setGoalNavLinkEventListeners() {
  $('a#prevgoal').on('click', function(e) {
    e.preventDefault();
    getPreviousGoal(e.target);
  });
  $('a#nextgoal').on('click', function(e) {
    e.preventDefault();
    getNextGoal(e.target);
  });
}

// GENERAL UTILITY

function clearContent() {
  $('div#content').text('')
}
