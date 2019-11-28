Class {
	#name : #SCExporterTest,
	#superclass : #SCExporterImportTest,
	#category : #'STONCustomizer-Tests'
}

{ #category : #tests }
SCExporterTest >> testExportInFile [
	| file |
	file := FileSystem memory / 'test.ston'.
	SCExporter export: peoples inFile: file.
	self
		assert: file contents
		equals:
			'[
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
]'
]

{ #category : #tests }
SCExporterTest >> testExportOnStream [
	self
		assert: (String streamContents: [ :s | SCExporter export: peoples onStream: s ])
		equals:
			'[
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
]'
]

{ #category : #tests }
SCExporterTest >> testToString [
	self
		assert: (SCExporter toString: peoples)
		equals:
			'[
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
]'
]
