"
Description
--------------------

I am a class responsible to process a variable before exporting it via a SCExporter and before importing it via a SCImporter.

I am to be returned by a class side method of the class to export with th pragma #stonCutomizationFor:.

Examples
--------------------

	countryCustomizer
	<stonCustomizationFor: #country>
	^ STONCustomizer
		readBlock: [ :person :value :reader | person country: (reader state countryNamed: value) ]
		writeBlock: [ :person | person country name ]
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	readBlock:		<aBlock>		A block to execute while reading the value of the concerned variable. I take three parameters: the object holding the variable, the value read from STON and the reader holding optional state.
	writeBlock:		<aBlock>		A block to execute while writing the value of the concerned variable. I take two parameters: the jobect holding the variable and the writer.

"
Class {
	#name : #STONCustomizer,
	#superclass : #Object,
	#instVars : [
		'readBlock',
		'writeBlock'
	],
	#category : #STONCustomizer
}

{ #category : #'instance creation' }
STONCustomizer class >> readBlock: aBlock writeBlock: aBlock2 [
	^ self new
		readBlock: aBlock;
		writeBlock: aBlock2;
		yourself
]

{ #category : #accessing }
STONCustomizer >> readBlock [
	^ readBlock
]

{ #category : #accessing }
STONCustomizer >> readBlock: anObject [
	readBlock := anObject
]

{ #category : #accessing }
STONCustomizer >> writeBlock [
	^ writeBlock
]

{ #category : #accessing }
STONCustomizer >> writeBlock: anObject [
	writeBlock := anObject
]
