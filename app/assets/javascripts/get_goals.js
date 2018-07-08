function getGoals() {
  $.ajax({
    method: 'GET',
    url: '/goals',
    contentType: 'application/json'
  }).done(function(response) {
    response.forEach(obj => {
      new Goal(obj.id, obj.description, obj.start_date, obj.end_date, obj.interval, obj.priority, obj.user_id)
    })
    loadGoals();
  })
}

function loadGoals() {
  let goalsHTML = '<div class="col-4">'
  goalsHTML += '<h4>User Goals</h4>'
  store.goals.forEach(goal => {
    goalsHTML += `${goal.description}<br />`
    goalsHTML += `<span class="end-date">${goal.interval.toUpperCase()}&nbsp;&middot;&nbsp;THROUGH ${goal.endDate}</span><br />`
  })
  goalsHTML += '</div>'

  $('div#content').append(goalsHTML)
}

function getGoalsByPriority(priority, completed=false) {
    // build from Goal Helper method
  }
