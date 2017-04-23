ALTER TABLE Network DROP CONSTRAINT IF EXISTS Network_fk0;

ALTER TABLE LevelNetwork DROP CONSTRAINT IF EXISTS LevelNetwork_fk0;

ALTER TABLE LevelNetwork DROP CONSTRAINT IF EXISTS LevelNetwork_fk1;

ALTER TABLE NetworkResource DROP CONSTRAINT IF EXISTS NetworkResource_fk0;

ALTER TABLE NetworkResource DROP CONSTRAINT IF EXISTS NetworkResource_fk1;

ALTER TABLE NetworkLevelResourses DROP CONSTRAINT IF EXISTS NetworkLevelResourses_fk0;

ALTER TABLE NetworkLevelResourses DROP CONSTRAINT IF EXISTS NetworkLevelResourses_fk1;

ALTER TABLE NetElement DROP CONSTRAINT IF EXISTS NetElement_fk0;

ALTER TABLE CompositionNetElement DROP CONSTRAINT IF EXISTS CompositionNetElement_fk0;

ALTER TABLE PositionedRelation DROP CONSTRAINT IF EXISTS PositionedRelation_fk0;

ALTER TABLE ElementPartCollection DROP CONSTRAINT IF EXISTS ElementPartCollection_fk0;

ALTER TABLE ElementPartCollection DROP CONSTRAINT IF EXISTS ElementPartCollection_fk1;

ALTER TABLE OrderedCollection DROP CONSTRAINT IF EXISTS OrderedCollection_fk0;

ALTER TABLE OrderedCollectionElements DROP CONSTRAINT IF EXISTS OrderedCollectionElements_fk0;

ALTER TABLE OrderedCollectionElements DROP CONSTRAINT IF EXISTS OrderedCollectionElements_fk1;

ALTER TABLE UnorderedCollection DROP CONSTRAINT IF EXISTS UnorderedCollection_fk0;

ALTER TABLE UnoderedCollectionElements DROP CONSTRAINT IF EXISTS UnoderedCollectionElements_fk0;

ALTER TABLE UnoderedCollectionElements DROP CONSTRAINT IF EXISTS UnoderedCollectionElements_fk1;

ALTER TABLE PositioningNetElement DROP CONSTRAINT IF EXISTS PositioningNetElement_fk0;

ALTER TABLE AssociatedNetElement DROP CONSTRAINT IF EXISTS AssociatedNetElement_fk0;

ALTER TABLE LinearElement DROP CONSTRAINT IF EXISTS LinearElement_fk0;

ALTER TABLE NonLinearElement DROP CONSTRAINT IF EXISTS NonLinearElement_fk0;

ALTER TABLE Relation DROP CONSTRAINT IF EXISTS Relation_fk0;

ALTER TABLE OrderedAssociatedNetElement DROP CONSTRAINT IF EXISTS OrderedAssociatedNetElement_fk0;

ALTER TABLE OrderedAssociatedNetElement DROP CONSTRAINT IF EXISTS OrderedAssociatedNetElement_fk1;

ALTER TABLE PositioningSystem DROP CONSTRAINT IF EXISTS PositioningSystem_fk0;

ALTER TABLE LinearPositioningSystem DROP CONSTRAINT IF EXISTS LinearPositioningSystem_fk0;

ALTER TABLE LinearAnchorPoint DROP CONSTRAINT IF EXISTS LinearAnchorPoint_fk0;

ALTER TABLE LinearAnchorPoint DROP CONSTRAINT IF EXISTS LinearAnchorPoint_fk1;

ALTER TABLE IntrinsicCoordinate DROP CONSTRAINT IF EXISTS IntrinsicCoordinate_fk0;

ALTER TABLE LinearCoordinate DROP CONSTRAINT IF EXISTS LinearCoordinate_fk0;

ALTER TABLE LinearCoordinate DROP CONSTRAINT IF EXISTS LinearCoordinate_fk1;

ALTER TABLE GeometricCoordinate DROP CONSTRAINT IF EXISTS GeometricCoordinate_fk0;

ALTER TABLE AssociatedPositioningSystem DROP CONSTRAINT IF EXISTS AssociatedPositioningSystem_fk0;

ALTER TABLE AssociatedPositioningSystem DROP CONSTRAINT IF EXISTS AssociatedPositioningSystem_fk1;

ALTER TABLE AssociatedPositioningSystem DROP CONSTRAINT IF EXISTS AssociatedPositioningSystem_fk2;

ALTER TABLE NetEntity DROP CONSTRAINT IF EXISTS NetEntity_fk0;

ALTER TABLE LocatedNetEntity DROP CONSTRAINT IF EXISTS LocatedNetEntity_fk0;

ALTER TABLE EntityLocation DROP CONSTRAINT IF EXISTS EntityLocation_fk0;

ALTER TABLE EntityLocations DROP CONSTRAINT IF EXISTS EntityLocations_fk0;

ALTER TABLE EntityLocations DROP CONSTRAINT IF EXISTS EntityLocations_fk1;

ALTER TABLE SpotLocation DROP CONSTRAINT IF EXISTS SpotLocation_fk0;

ALTER TABLE SpotLocation DROP CONSTRAINT IF EXISTS SpotLocation_fk1;

ALTER TABLE SpotLocationIntrinsic DROP CONSTRAINT IF EXISTS SpotLocationIntrinsic_fk0;

ALTER TABLE SpotLocationCoordinate DROP CONSTRAINT IF EXISTS SpotLocationCoordinate_fk0;

ALTER TABLE SpotLocationCoordinate DROP CONSTRAINT IF EXISTS SpotLocationCoordinate_fk1;

ALTER TABLE LinearLocation DROP CONSTRAINT IF EXISTS LinearLocation_fk0;

ALTER TABLE GeometricPositioningSystem DROP CONSTRAINT IF EXISTS GeometricPositioningSystem_fk0;

ALTER TABLE LinearLocationNetElements DROP CONSTRAINT IF EXISTS LinearLocationNetElements_fk0;

ALTER TABLE LinearLocationNetElements DROP CONSTRAINT IF EXISTS LinearLocationNetElements_fk1;

ALTER TABLE LinearLocationCoordinate DROP CONSTRAINT IF EXISTS LinearLocationCoordinate_fk0;

ALTER TABLE LinearLocationCoordinates DROP CONSTRAINT IF EXISTS LinearLocationCoordinates_fk0;

ALTER TABLE LinearLocationCoordinates DROP CONSTRAINT IF EXISTS LinearLocationCoordinates_fk1;

ALTER TABLE AreaLocation DROP CONSTRAINT IF EXISTS AreaLocation_fk0;

ALTER TABLE IntrinsicCoordinates DROP CONSTRAINT IF EXISTS IntrinsicCoordinates_fk0;

ALTER TABLE IntrinsicCoordinates DROP CONSTRAINT IF EXISTS IntrinsicCoordinates_fk1;

ALTER TABLE AssociatedNetElements DROP CONSTRAINT IF EXISTS AssociatedNetElements_fk0;

ALTER TABLE AssociatedNetElements DROP CONSTRAINT IF EXISTS AssociatedNetElements_fk1;

ALTER TABLE NetElementsRelations DROP CONSTRAINT IF EXISTS NetElementsRelations_fk0;

ALTER TABLE NetElementsRelations DROP CONSTRAINT IF EXISTS NetElementsRelations_fk1;

ALTER TABLE PositionedElementsRelation DROP CONSTRAINT IF EXISTS PositionedElementsRelation_fk0;

ALTER TABLE PositionedElementsRelation DROP CONSTRAINT IF EXISTS PositionedElementsRelation_fk1;

DROP TABLE IF EXISTS BaseObject;

DROP TABLE IF EXISTS Network;

DROP TABLE IF EXISTS LevelNetwork;

DROP TABLE IF EXISTS NetworkResource;

DROP TABLE IF EXISTS NetworkLevelResourses;

DROP TABLE IF EXISTS NetElement;

DROP TABLE IF EXISTS CompositionNetElement;

DROP TABLE IF EXISTS PositionedRelation;

DROP TABLE IF EXISTS ElementPartCollection;

DROP TABLE IF EXISTS OrderedCollection;

DROP TABLE IF EXISTS OrderedCollectionElements;

DROP TABLE IF EXISTS UnorderedCollection;

DROP TABLE IF EXISTS UnoderedCollectionElements;

DROP TABLE IF EXISTS PositioningNetElement;

DROP TABLE IF EXISTS AssociatedNetElement;

DROP TABLE IF EXISTS LinearElement;

DROP TABLE IF EXISTS NonLinearElement;

DROP TABLE IF EXISTS Relation;

DROP TABLE IF EXISTS OrderedAssociatedNetElement;

DROP TABLE IF EXISTS PositioningSystem;

DROP TABLE IF EXISTS LinearPositioningSystem;

DROP TABLE IF EXISTS LinearAnchorPoint;

DROP TABLE IF EXISTS PositioningSystemCoordinate;

DROP TABLE IF EXISTS IntrinsicCoordinate;

DROP TABLE IF EXISTS LinearCoordinate;

DROP TABLE IF EXISTS GeometricCoordinate;

DROP TABLE IF EXISTS AssociatedPositioningSystem;

DROP TABLE IF EXISTS NetEntity;

DROP TABLE IF EXISTS LocatedNetEntity;

DROP TABLE IF EXISTS EntityLocation;

DROP TABLE IF EXISTS EntityLocations;

DROP TABLE IF EXISTS SpotLocation;

DROP TABLE IF EXISTS SpotLocationIntrinsic;

DROP TABLE IF EXISTS SpotLocationCoordinate;

DROP TABLE IF EXISTS LinearLocation;

DROP TABLE IF EXISTS GeometricPositioningSystem;

DROP TABLE IF EXISTS LinearLocationNetElements;

DROP TABLE IF EXISTS LinearLocationCoordinate;

DROP TABLE IF EXISTS LinearLocationCoordinates;

DROP TABLE IF EXISTS AreaLocation;

DROP TABLE IF EXISTS IntrinsicCoordinates;

DROP TABLE IF EXISTS AssociatedNetElements;

DROP TABLE IF EXISTS NetElementsRelations;

DROP TABLE IF EXISTS PositionedElementsRelation;

DROP EXTENSION IF EXISTS "uuid-ossp";

DROP TYPE IF EXISTS usage;

DROP TYPE IF EXISTS lrsMethod;

DROP TYPE IF EXISTS applicationDirection;

DROP TYPE IF EXISTS orientation;

DROP TYPE IF EXISTS navigability;

DROP FUNCTION IF EXISTS addBaseObject(name varchar(100), validFrom date, validTo date);
DROP FUNCTION IF EXISTS addBaseObject(name varchar(100), validTo date);

DROP FUNCTION IF EXISTS addNetwork(name varchar(100), validFrom date, validTo date);
DROP FUNCTION IF EXISTS addNetwork(name varchar(100), validTo date);

DROP FUNCTION IF EXISTS addLevelNetwork(name varchar(100), networkName varchar(100), validFrom date, validTo date);
DROP FUNCTION IF EXISTS addLevelNetwork(name varchar(100), networkName varchar(100), validTo date);

DROP FUNCTION IF EXISTS addNetworkResource(name varchar(100), networkName varchar(100), validFrom date, validTo date);
DROP FUNCTION IF EXISTS addNetworkResource(name varchar(100), networkName varchar(100), validTo date);

DROP FUNCTION IF EXISTS setNetworkResourceLevel(networkLevelName varchar(100), networkResourceName varchar(100));

DROP FUNCTION IF EXISTS deleteBaseObject(name varchar(100));

DROP FUNCTION IF EXISTS deleteNetwork(name varchar(100));

DROP FUNCTION IF EXISTS deleteNetworkResource(name varchar(100));

DROP FUNCTION IF EXISTS deleteLevelNetwork(name varchar(100));


DROP FUNCTION IF EXISTS updateBaseObject(oldName varchar(100), newName varchar(100), validFrom date, validTo date);
DROP FUNCTION IF EXISTS updateBaseObject(oldName varchar(100), newName varchar(100), validTo date);

DROP FUNCTION IF EXISTS updateNetwork(oldName varchar(100), newName varchar(100), validFrom date, validTo date);
DROP FUNCTION IF EXISTS updateNetwork(oldName varchar(100), newName varchar(100), validTo date);

DROP FUNCTION IF EXISTS updateNetworkResource(oldName varchar(100), newName varchar(100), validFrom date, validTo date, networkName varchar(100));
DROP FUNCTION IF EXISTS updateNetworkResource(oldName varchar(100), newName varchar(100), validTo date, networkName varchar(100));

DROP FUNCTION IF EXISTS updateLevelNetwork(oldName varchar(100), newName varchar(100), validFrom date, validTo date, networkName varchar(100));
DROP FUNCTION IF EXISTS updateLevelNetwork(oldName varchar(100), newName varchar(100), validTo date, networkName varchar(100));

DROP FUNCTION IF EXISTS updateNetworkResourceLevel(networkResourceName varchar(100), networkResourceLevelOldName varchar(100), networkResourceLevelNewName varchar(100));

