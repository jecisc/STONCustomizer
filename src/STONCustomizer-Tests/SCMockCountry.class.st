Class {
	#name : 'SCMockCountry',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'STONCustomizer-Tests',
	#package : 'STONCustomizer-Tests'
}

{ #category : 'instance creation' }
SCMockCountry class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : 'accessing' }
SCMockCountry >> name [
	^ name
]

{ #category : 'accessing' }
SCMockCountry >> name: anObject [
	name := anObject
]
