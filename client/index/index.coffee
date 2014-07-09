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