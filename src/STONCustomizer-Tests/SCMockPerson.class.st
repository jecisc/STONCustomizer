Class {
	#name : #SCMockPerson,
	#superclass : #Object,
	#instVars : [
		'country',
		'yearOfBirth'
	],
	#category : #'STONCustomizer-Tests'
}

{ #category : #'instance creation' }
SCMockPerson class >> country: aCountry yearOfBirth: aYear [
	^ self new
		country: aCountry;
		yearOfBirth: aYear;
		yourself
]

{ #category : #customizations }
SCMockPerson class >> countryCustomizer [
	<stonCustomizationFor: #country>
	^ STONCustomizer
		readBlock: [ :person :value :reader | person country: (reader state countryNamed: value) ]
		writeBlock: [ :person | person country name ]
]

{ #category : #customizations }
SCMockPerson class >> yearOfBirthCustomizer [
	<stonCustomizationFor: #yearOfBirth>
	^ STONCustomizer
		readBlock: [ :person :value :reader | person yearOfBirth: value asYear ]
		writeBlock: [ :person | person yearOfBirth start year ]
]

{ #category : #accessing }
SCMockPerson >> country [
	^ country
]

{ #category : #accessing }
SCMockPerson >> country: anObject [
	country := anObject
]

{ #category : #accessing }
SCMockPerson >> yearOfBirth [
	^ yearOfBirth
]

{ #category : #accessing }
SCMockPerson >> yearOfBirth: anObject [
	yearOfBirth := anObject
]
