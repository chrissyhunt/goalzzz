function getGoals() {
  $.ajax({
    method: 'GET',
    url: '/goals',
    contentType: 'application/json'
  }).done(function(response) {
    response.forEach(obj => {
      new Goal(obj.description, obj.start_date, obj.end_date, obj.interval, obj.priority, obj.user_id)
    })
    loadGoals();
  })
}

function loadGoals() {
  let goalsHTML = '<h4>User Goals</h4>'
  store.goals.forEach(goal => {
    goalsHTML += `<p>${goal.description}</p>`
  })

  $('div#content').append(goalsHTML)
}
