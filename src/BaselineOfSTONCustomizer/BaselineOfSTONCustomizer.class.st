"
I am a baseline to define the structure and dependencies of the STONCustomizer project.
"
Class {
	#name : #BaselineOfSTONCustomizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfSTONCustomizer
}

{ #category : #baseline }
BaselineOfSTONCustomizer >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'STONCustomizer';
				package: 'STONCustomizer-Tests' with: [ spec requires: #('STONCustomizer') ].

			"Groups"
			spec
				group: 'Core' with: #('STONCustomizer');
				group: 'Tests' with: #('STONCustomizer') ].
]

{ #category : #accessing }
BaselineOfSTONCustomizer >> projectClass [
	^ MetacelloCypressBaselineProject
]
