"
Description
--------------------

I am an importer processing STON customizations while importing variables of a class.

The user can give me a state to use during the import.

Examples
--------------------

	| countryHolder france belgium germany peoples export |
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

	export := SCExporter toString: peoples.
	
	SCImporter fromString: export state: countryHolder	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	state:		<anObject> 		The user can set this state to access to it during the import of objects.
"
Class {
	#name : 'SCImporter',
	#superclass : 'STONReader',
	#instVars : [
		'state'
	],
	#category : 'STONCustomizer',
	#package : 'STONCustomizer'
}

{ #category : 'instance creation' }
SCImporter class >> fromStream: aStream state: aModel [
	^ self new
		state: aModel;
		importFromStream: aStream
]

{ #category : 'instance creation' }
SCImporter class >> fromString: aString state: aModel [
	^ self fromStream: aString readStream state: aModel
]

{ #category : 'instance creation' }
SCImporter class >> importFromFile: aFile state: aModel [
	aFile exists ifFalse: [ (FileDoesNotExistException fileName: aFile fileName) signal ].

	^ aFile readStreamDo: [ :s | self fromStream: s state: aModel ]
]

{ #category : 'parsing' }
SCImporter >> getCustomizationsFor: anObject [
	^ (Pragma allNamed: #stonCustomizationFor: from: anObject class class to: Object)
		inject: Dictionary new
		into: [ :dict :p | 
			dict at: (p argumentAt: 1) put: (anObject class perform: p method selector).
			dict ]
]

{ #category : 'parsing' }
SCImporter >> importFromStream: aStream [
	^ (self on: aStream) next
]

{ #category : 'parsing' }
SCImporter >> parseNamedInstVarsFor: anObject [

	| customizers |
	customizers := self getCustomizationsFor: anObject.
	self parseMapDo: [ :instVarName :value |
		customizers
			at: instVarName asSymbol
			ifPresent: [ :customizer |
				customizer readBlock cull: anObject cull: value cull: self ]
			ifAbsent: [
				[ anObject instVarNamed: instVarName put: value ]
					on: Error
					do: [ "The instance variable is no longer in the model. We do nothing in that case to not break compatibility with ston exported before."
						 ] ] ]
]

{ #category : 'accessing' }
SCImporter >> state [
	^ state
]

{ #category : 'accessing' }
SCImporter >> state: anObject [
	state := anObject
]
