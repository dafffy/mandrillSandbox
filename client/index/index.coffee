Session.setDefault 'active_manifest', {
	name: 'CoreApplications'
	dom: {
		catalogs: ['production']
		included_manifests: ['Core']
		managed_installs: ['Firefox', 'Chrome', 'VLC']
		managed_uninstalls: ['AppleWorks']
		optional_installs: ['twitter']
		managed_updates: ['twitter']
	}
}

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
	manifest = Session.get 'active_manifest'
	if manifest?
		manifest.name


Template.index.managed_installs = ()->
	manifest = Session.get 'active_manifest'
	if manifest?
		manifest.dom.managed_installs

Template.index.managed_uninstalls = ()->
	manifest = Session.get 'active_manifest'
	if manifest?
		manifest.dom.managed_uninstalls

Template.index.optional_installs = ()->
	manifest = Session.get 'active_manifest'
	if manifest?
		manifest.dom.optional_installs

Template.index.managed_updates = ()->
	manifest = Session.get 'active_manifest'
	if manifest?
		manifest.dom.managed_updates


Template.index.events {
	'blur td': (event)->
		original_value = String(this)
		key = $(event.target).data('key')
		text = $(event.target).text()
		manifest = Session.get 'active_manifest'
		if manifest?
			idx = manifest.dom[key].indexOf original_value
			manifest.dom[key][idx] = text.trim()
			Session.set 'active_manifest', manifest
		

	'keydown td': (event)->
		original_value = String(this)
		key = $(event.target).data('key')
		text = $(event.target).text()
		key_code = event.keyCode
		switch key_code
			# esc should blur the field
			when 27
				$(event.target).blur()

			# delete should remove the entry
			when 8
				if $(event.target).text() is ''
					manifest = Session.get 'active_manifest'
					if manifest?
						idx = manifest.dom[key].indexOf original_value
						manifest.dom[key].splice(idx, 1)
						Session.set 'active_manifest', manifest
						$($('[data-key="' + key + '"]')[idx-1]).focus()

			# enter/return should add a new blank entry after the target
			when 13
				event.preventDefault()
				if $(event.target).text() isnt ''
					manifest = Session.get 'active_manifest'
					if manifest?
						idx = 1 + manifest.dom[key].indexOf original_value
						manifest.dom[key].splice(idx, 0, '')
						Session.set 'active_manifest', manifest
						window.setTimeout ()->
							$($('[data-key="' + key + '"]')[idx]).focus()
						, 5
}