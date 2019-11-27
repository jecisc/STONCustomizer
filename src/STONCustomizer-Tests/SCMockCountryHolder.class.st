Class {
	#name : #SCMockCountryHolder,
	#superclass : #Object,
	#instVars : [
		'countries'
	],
	#category : #'STONCustomizer-Tests'
}

{ #category : #accessing }
SCMockCountryHolder >> countries [
	^ countries
]

{ #category : #adding }
SCMockCountryHolder >> countryNamed: aString [
	^ countries
		detect: [ :e | e name = aString ]
		ifNone: [ | country |
			country := SCMockCountry named: aString.
			countries add: country.
			country ]
]

{ #category : #initialization }
SCMockCountryHolder >> initialize [
	super initialize.
	countries := OrderedCollection new
]
