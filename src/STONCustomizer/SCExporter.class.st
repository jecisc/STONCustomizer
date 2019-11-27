Class {
	#name : #SCExporter,
	#superclass : #STONWriter,
	#category : #STONCustomizer
}

{ #category : #writing }
SCExporter class >> export: anObject inFile: aFileReference [
	^ self new export: anObject inFile: aFileReference
]

{ #category : #writing }
SCExporter class >> toString: anObject [
	^ self new toString: anObject
]

{ #category : #writing }
SCExporter >> export: anObject inFile: aFileReference [
	aFileReference writeStreamDo: [ :s | self export: anObject onStream: s ]
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

{ #category : #'instance creation' }
SCExporter >> toString: anObject [
	^ String streamContents: [ :stream | self export: anObject onStream: stream ]
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
