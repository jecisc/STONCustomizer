Class {
	#name : #SCExporterImportTest,
	#superclass : #TestCase,
	#instVars : [
		'countryHolder',
		'peoples'
	],
	#category : #'STONCustomizer-Tests'
}

{ #category : #testing }
SCExporterImportTest class >> isAbstract [
	^ self = SCExporterImportTest
]

{ #category : #running }
SCExporterImportTest >> setUp [
	| france belgium germany |
	super setUp.
	countryHolder := SCMockCountryHolder new.

	france := countryHolder countryNamed: 'France'.
	belgium := countryHolder countryNamed: 'Belgium'.
	germany := countryHolder countryNamed: 'Germany'.

	peoples := {(SCMockPerson country: france yearOfBirth: 1993 asYear) . (SCMockPerson country: france yearOfBirth: 1992 asYear).
	(SCMockPerson country: belgium yearOfBirth: 1990 asYear) . (SCMockPerson country: germany yearOfBirth: 1999 asYear)}
]
