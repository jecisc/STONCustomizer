"
Description
--------------------

I am an exporter processing STON customizations while exporting variables of a class.

Examples
--------------------

	| countryHolder france belgium germany peoples |
	countryHolder := SCMockCountryHolder new.

	france := countryHolder countryNamed: 'France'.
	belgium := countryHolder countryNamed: 'Belgium'.
	germany := countryHolder countryNamed: 'Germany'.

	peoples := {
		(SCMockPerson country: france yearOfBirth: 1993 asYear).
		(SCMockPerson country: france yearOfBirth: 1992 asYear).
		(SCMockPerson country: belgium yearOfBirth: 1990 asYear).
		(SCMockPerson country: germany yearOfBirth: 1999 asYear )
	}.

	SCExporter toString: peoples.
	
	SCExporter export: peoples inFile: (FileSystem memory / 'test.ston')

"
Class {
	#name : #SCExporter,
	#superclass : #STONWriter,
	#category : #STONCustomizer
}

{ #category : #writing }
SCExporter class >> export: anObject inFile: aFileReference [
	^ aFileReference writeStreamDo: [ :s | self export: anObject onStream: s ]
]

{ #category : #'as yet unclassified' }
SCExporter class >> export: anObject onStream: aStream [
	^ self new export: anObject onStream: aStream
]

{ #category : #writing }
SCExporter class >> toString: anObject [
	^ String streamContents: [ :s | self export: anObject onStream: s ]
]

{ #category : #writing }
SCExporter >> export: anObject onStream: stream [
	^ (self on: stream)
		prettyPrint: true;
		nextPut: anObject
]

{ #category : #writing }
SCExporter >> getCustomizationsFor: anObject [
	^ (Pragma allNamed: #stonCustomizationFor: from: anObject class class to: Object)
		inject: Dictionary new
		into: [ :dict :p | 
			dict at: (p argumentAt: 1) put: (anObject class perform: p method selector).
			dict ]
]

{ #category : #writing }
SCExporter >> writeObject: anObject [
	anObject class stonAllInstVarNames
		ifEmpty: [ self writeObject: anObject do: [ self encodeMap: #() ] ]
		ifNotEmpty: [ :instanceVariableNames | 
			| customizers |
			customizers := self getCustomizationsFor: anObject.
			self
				writeObject: anObject
				streamMap: [ :dictionary | 
					instanceVariableNames
						do: [ :each | 
							(anObject instVarNamed: each)
								ifNotNil: [ :value | 
									dictionary
										at: each asSymbol
										put:
											(customizers
												at: each asSymbol
												ifPresent: [ :customizer | customizer writeBlock cull: anObject cull: self ]
												ifAbsent: [ value ]) ]
								ifNil: [ 
									anObject stonShouldWriteNilInstVars
										ifTrue: [ dictionary at: each asSymbol put: nil ] ] ] ] ]
]
