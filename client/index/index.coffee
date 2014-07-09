Template.index.manifests = ()->
	[
		'Core'
		'CoreApplications'
		'site_default'
		'faculty_staff'
		'lab1'
		'lab2'
		'lab3'
	].sort()

Template.index.manifest_is_selected = ()->
	if String(this) is 'CoreApplications'
		'active'



Template.index.title = ()->
	'CoreApplications'


Template.index.managed_installs = ()->
	['Firefox', 'Chrome', 'VLC']
Template.index.managed_uninstalls = ()->
	['oracle_calendar', 'AppleWorks']
Template.index.optional_installs = ()->
	['twitter']
Template.index.managed_updates = ()->
	['twitter']


Template.index.events {
	'keydown td': (event)->
		console.log $(event.target).text()
		console.log event.keyCode
		switch event.keyCode
			when 27
				$(event.target).blur()
			when 8
				if $(event.target).text() is ''
					console.log 'Should be deleting this entry'
			when 13
				event.preventDefault()
				if $(event.target).text() isnt ''
					console.log 'Should be adding a new entry at index+1'
}