Class {
	#name : #SCImporterTest,
	#superclass : #SCExporterImportTest,
	#category : #'STONCustomizer-Tests'
}

{ #category : #tests }
SCImporterTest >> testFromStreamState [
	| string importedPeoples |
	string := SCExporter toString: peoples.
	importedPeoples := SCImporter fromStream: string readStream state: countryHolder.
	self assert: importedPeoples size equals: 4.

	"Ensure those instances are all in country holder."
	self assert: countryHolder countries size equals: 3.
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 1) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 2) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 3) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 4) country ]).
	self assert: (importedPeoples detect: [ :each | each country name = 'Germany' ]) yearOfBirth equals: 1999 asYear.
	self assert: (importedPeoples detect: [ :each | each country name = 'Belgium' ]) yearOfBirth equals: 1990 asYear
]

{ #category : #tests }
SCImporterTest >> testFromStringState [
	| string importedPeoples |
	string := SCExporter toString: peoples.
	importedPeoples := SCImporter fromString: string state: countryHolder.
	self assert: importedPeoples size equals: 4.

	"Ensure those instances are all in country holder."
	self assert: countryHolder countries size equals: 3.
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 1) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 2) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 3) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 4) country ]).
	self assert: (importedPeoples detect: [ :each | each country name = 'Germany' ]) yearOfBirth equals: 1999 asYear.
	self assert: (importedPeoples detect: [ :each | each country name = 'Belgium' ]) yearOfBirth equals: 1990 asYear
]

{ #category : #tests }
SCImporterTest >> testImportFromFileState [
	| file importedPeoples |
	file := FileSystem memory / 'test.ston'.
	SCExporter export: peoples inFile: file.
	importedPeoples := SCImporter importFromFile: file state: countryHolder.
	self assert: importedPeoples size equals: 4.

	"Ensure those instances are all in country holder."
	self assert: countryHolder countries size equals: 3.
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 1) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 2) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 3) country ]).
	self assert: (countryHolder countries anySatisfy: [ :country | country == (importedPeoples at: 4) country ]).
	self assert: (importedPeoples detect: [ :each | each country name = 'Germany' ]) yearOfBirth equals: 1999 asYear.
	self assert: (importedPeoples detect: [ :each | each country name = 'Belgium' ]) yearOfBirth equals: 1990 asYear
]
