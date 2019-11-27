Class {
	#name : #SCImporter,
	#superclass : #STONReader,
	#instVars : [
		'state'
	],
	#category : #STONCustomizer
}

{ #category : #'instance creation' }
SCImporter class >> fromString: aString state: aModel [
	^ self new
		state: aModel;
		fromString: aString
]

{ #category : #'instance creation' }
SCImporter class >> importFromFile: aFile state: aModel [
	^ self new
		state: aModel;
		importFromFile: aFile
]

{ #category : #'instance creation' }
SCImporter >> fromString: aString [
	^ (self on: aString readStream) next
]

{ #category : #parsing }
SCImporter >> getCustomizationsFor: anObject [
	^ (Pragma allNamed: #stonCustomizationFor: from: anObject class class to: Object)
		inject: Dictionary new
		into: [ :dict :p | 
			dict at: (p argumentAt: 1) put: (anObject class perform: p method selector).
			dict ]
]

{ #category : #parsing }
SCImporter >> importFromFile: file [
	^ file exists
		ifTrue: [ (self on: file readStream) next ]
		ifFalse: [ (FileDoesNotExistException fileName: file fileName) signal ]
]

{ #category : #parsing }
SCImporter >> parseNamedInstVarsFor: anObject [
	| customizers |
	customizers := self getCustomizationsFor: anObject.
	self
		parseMapDo: [ :instVarName :value | 
			customizers
				at: instVarName asSymbol
				ifPresent: [ :customizer | customizer readBlock cull: anObject cull: value cull: self ]
				ifAbsent: [ 
					[ anObject instVarNamed: instVarName put: value ]
						on: Error
						do: [ 
							"The instance variable is no longer in the model. We do nothing in that case to not break compatibility with ston exported before."
							 ] ] ]
]

{ #category : #accessing }
SCImporter >> state [
	^ state
]

{ #category : #accessing }
SCImporter >> state: anObject [
	state := anObject
]
