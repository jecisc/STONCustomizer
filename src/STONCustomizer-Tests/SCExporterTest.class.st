Class {
	#name : 'SCExporterTest',
	#superclass : 'SCExporterImportTest',
	#category : 'STONCustomizer-Tests',
	#package : 'STONCustomizer-Tests'
}

{ #category : 'tests' }
SCExporterTest >> testExportInFile [

	| file |
	file := FileSystem memory / 'test.ston'.
	SCExporter export: peoples inFilePretty: file.
	self assert: file contents equals: ('[
	SCMockPerson {
		#country : ''France'',
		#yearOfBirth : 1993
	},
	SCMockPerson {
		#country : ''France'',
		#yearOfBirth : 1992
	},
	SCMockPerson {
		#country : ''Belgium'',
		#yearOfBirth : 1990
	},
	SCMockPerson {
		#country : ''Germany'',
		#yearOfBirth : 1999
	}
]' copyReplaceAll: Character cr asString with: Character lf asString)
]

{ #category : 'tests' }
SCExporterTest >> testExportOnStream [

	self
		assert: (String streamContents: [ :s |
				 SCExporter export: peoples onStreamPretty: s ])
		equals: ('[
	SCMockPerson {
		#country : ''France'',
		#yearOfBirth : 1993
	},
	SCMockPerson {
		#country : ''France'',
		#yearOfBirth : 1992
	},
	SCMockPerson {
		#country : ''Belgium'',
		#yearOfBirth : 1990
	},
	SCMockPerson {
		#country : ''Germany'',
		#yearOfBirth : 1999
	}
]' copyReplaceAll: Character cr asString with: Character lf asString)
]

{ #category : 'tests' }
SCExporterTest >> testToString [

	self assert: (SCExporter toStringPretty: peoples) equals: ('[
	SCMockPerson {
		#country : ''France'',
		#yearOfBirth : 1993
	},
	SCMockPerson {
		#country : ''France'',
		#yearOfBirth : 1992
	},
	SCMockPerson {
		#country : ''Belgium'',
		#yearOfBirth : 1990
	},
	SCMockPerson {
		#country : ''Germany'',
		#yearOfBirth : 1999
	}
]' copyReplaceAll: Character cr asString with: Character lf asString)
]
