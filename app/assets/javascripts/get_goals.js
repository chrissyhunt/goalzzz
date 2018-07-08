function getAllGoals() {
  $.ajax({
    method: 'GET',
    url: '/goals',
    contentType: 'application/json'
  }).done(function(response) {
    response.forEach(obj => {
      new Goal(obj.id, obj.description, obj.start_date, obj.end_date, obj.interval, obj.priority, obj.user_id)
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

function getGoalResults(goal) {
  console.log('load goal triggered, ID: ', goal.dataset.id);
  $.ajax({
    method: 'GET',
    url: `/goals/${goal.dataset.id}.json`,
    contentType: 'application/json'
  }).done(function(response) {
    response.results.forEach(obj => {
      new Result(obj.id, obj.goal_id, obj.status, obj.date)
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
  // some logic to sort results
  html += '</div></div></div>'
  $('div#content').append(html)
}

function generateResultsDisplay(goal) {
  let goalDateRange = goal.generateDateRange()
  let html = ''
  // store.results.forEach(result => {
  //   let divClass = 'blank-result';
  //   //build this out
  // })
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

function setGoalsEventListeners() {
  $('a').on('click', function(e) {
    e.preventDefault();
    getGoalResults(e.target);
  })
}

function clearContent() {
  $('div#content').text('')
}
