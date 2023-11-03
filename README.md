# STONCustomizer

 I am project to customize STON imports/exports.

[![Build Status](https://travis-ci.org/jecisc/STONCustomizer.svg?branch=master)](https://travis-ci.org/jecisc/STONCustomizer)

  - [Installation](#installation)
  - [Documentation](#documentation)
  - [Version management](#version-management)
  - [Smalltalk versions compatibility](#smalltalk-versions-compatibility)
  - [Contact](#contact)

## Installation

To install the project into your Pharo image, execute the following script: 

```Smalltalk
Metacello new
	githubUser: 'jecisc' project: 'STONCustomizer' commitish: 'v1.x.x' path: 'src';
	baseline: 'STONCustomizer';
	load
```

To add the project to your baseline:

```Smalltalk
spec
	baseline: 'STONCustomizer'
	with: [ spec repository: 'github://jecisc/STONCustomizer:v1.x.x/src' ]
```

Note you can replace the #master by another branch such as #development or a tag such as #v1.0.0, #v1.? or #v1.2.? .

## Documentation

> The code used in the example is available in `STONCustomizer-Tests` package.

In order to customize you STON export with this project you can add a class side method to the object to export with a pragma `<stonCustomazationFor:>` taking as parameter a symbol that is the name of an instance variable.
This method should return a STONCustomizer that will take care of the writing/reading of the variable content.

Example: 

```Smalltalk
yearOfBirthCustomizer
	<stonCustomizationFor: #yearOfBirth>
	^ STONCustomizer
		readBlock: [ :person :value :reader | person yearOfBirth: value asYear ]
		writeBlock: [ :person | person yearOfBirth start year ]
```

Here we have an object with a variable `#yearOfBirth` containing a year. To export this entity we do not wish to export a `Year` but an integer and transform it into a `Year` back when we read a STON file for this object.

Once you have objects using this, you can use `SCExporter` and `SCImporter` to export/import your objects.

The following examples will take those inputs as datas:

```Smalltalk
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
```

You can export it in strings:

```Smalltalk
export := SCExporter toString: peoples.

SCImporter fromString: export
```

Or in files:

```Smalltalk
file := FileSystem memory / 'test.ston'.

SCExporter export: peoples inFile: file.

SCImporter fromFile:: export
```

Or directly to a stream via `#export:toStream:` and `#fromStream:`.

Another feature of STONCustomization is that you can customize you import/export using states of your application. 

For example, in the previous example we have a `#countryHolder` acting as a cache for the countries. During the import of countries we might want to get back the instances it holds. 

In that case we can implement a customization this way:

```Smalltalk
countryCustomizer
	<stonCustomizationFor: #country>
	^ STONCustomizer
		readBlock: [ :person :value :reader | person country: (reader state countryNamed: value) ]
		writeBlock: [ :person | person country name ]
```

And export/import the objects this way:

```Smalltalk
export := SCExporter toString: peoples.

SCImporter fromString: export state: countryHolder
```

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions 		|
|-------------	|----------------------------------	|
| 1.x.x       	| Pharo 6.1, 7, 8, 9, 10, 11, 12	|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.me 
