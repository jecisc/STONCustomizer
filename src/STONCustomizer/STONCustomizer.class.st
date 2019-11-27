Class {
	#name : #STONCustomizer,
	#superclass : #Object,
	#instVars : [
		'readBlock',
		'writeBlock'
	],
	#category : #STONCustomizer
}

{ #category : #'as yet unclassified' }
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
