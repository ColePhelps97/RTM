CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE usage AS ENUM ('0', '1');

CREATE TYPE lrsMethod AS ENUM ('absolute', 'interpolation', 'relative');

CREATE TYPE applicationDirection AS ENUM ('both', 'normal', 'reverse');

CREATE TYPE orientation AS ENUM ('-1', '1');

CREATE TYPE navigability AS ENUM ('AB', 'BA', 'Both', 'None');

CREATE TYPE signal_type AS ENUM ('неизвестно', 'входной', 'выходной', 'маршрутный', 'проходной');

CREATE TYPE signal_generator_type AS ENUM ('ТРЦ', 'АЛСН', 'АЛС-ЕН');

CREATE TABLE BaseObject (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	name varchar UNIQUE,
	validFrom DATE,
	validTo DATE,
	CONSTRAINT BaseObject_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Network (
	id uuid NOT NULL,
	CONSTRAINT Network_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LevelNetwork (
	id uuid NOT NULL,
	networkId uuid NOT NULL,
	CONSTRAINT LevelNetwork_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE NetworkResource (
	id uuid NOT NULL,
	networkId uuid NOT NULL,
	CONSTRAINT NetworkResource_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE NetworkLevelResourses (
	levelNetworkId uuid NOT NULL,
	networkResourceId uuid NOT NULL,
	CONSTRAINT NetworkLevelResourses_pk PRIMARY KEY (LevelNetworkId,NetworkResourceId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE NetElement (
	id uuid NOT NULL,
	CONSTRAINT NetElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE CompositionNetElement (
	id uuid NOT NULL,
	CONSTRAINT CompositionNetElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE PositionedRelation (
	id uuid NOT NULL,
	positionOnA usage NOT NULL,
	positionOnB usage NOT NULL,
	navigability navigability NOT NULL,
	CONSTRAINT PositionedRelation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE ElementPartCollection (
	id uuid NOT NULL,
	compositionElemId uuid NOT NULL,
	CONSTRAINT ElementPartCollection_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE OrderedCollection (
	id uuid NOT NULL,
	sequence int NOT NULL,
	CONSTRAINT OrderedCollection_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE OrderedCollectionElements (
	netElementId uuid NOT NULL,
	orderedCollectionElementId uuid NOT NULL,
	CONSTRAINT OrderedCollectionElements_pk PRIMARY KEY (netElementId,OrderedCollectionElementId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE UnorderedCollection (
	id uuid NOT NULL,
	CONSTRAINT UnorderedCollection_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE UnoderedCollectionElements (
	netElementId uuid NOT NULL,
	unorderedCollectionElementId uuid NOT NULL,
	CONSTRAINT UnoderedCollectionElements_pk PRIMARY KEY (netElementId,UnorderedCollectionElementId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE PositioningNetElement (
	id uuid NOT NULL,
	CONSTRAINT PositioningNetElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE AssociatedNetElement (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	intrinsicCoordEnd double precision NOT NULL,
	keepsOrientation BOOLEAN NOT NULL,
	areaLocationId uuid NOT NULL,
	CONSTRAINT AssociatedNetElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearElement (
	id uuid NOT NULL,
	CONSTRAINT LinearElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

--Base Micro Level topologic elements
CREATE TABLE TrackEdge (
	id uuid NOT NULL,
	CONSTRAINT TrackEgde_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE NonLinearElement (
	id uuid NOT NULL,
	CONSTRAINT NonLinearElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE SwitchPoint (
	id uuid NOT NULL,
	CONSTRAINT SwitchPoint_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE Bufferstop (
	id uuid NOT NULL,
	CONSTRAINT Bufferstop_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE Relation (
	id uuid NOT NULL,
	CONSTRAINT Relation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE OrderedAssociatedNetElement (
	id uuid NOT NULL,
	intrinsicCoordBegin double precision NOT NULL,
	intrinsicCoordEnd double precision NOT NULL,
	keepsOrientation BOOLEAN NOT NULL,
	sequence int NOT NULL,
	linearLocationId uuid NOT NULL,
	CONSTRAINT OrderedAssociatedNetElement_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE PositioningSystem (
	id uuid NOT NULL,
	CONSTRAINT PositioningSystem_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearPositioningSystem (
	id uuid NOT NULL,
	endMeasure double precision NOT NULL,
	startMeasure double precision NOT NULL,
	linearReferencingMethod lrsMethod NOT NULL,
	units varchar NOT NULL,
	CONSTRAINT LinearPositioningSystem_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearAnchorPoint (
	id uuid NOT NULL,
	anchorName varchar NOT NULL,
	measure double precision NOT NULL,
	measureToNext double precision NOT NULL,
	linearPoistioningSystemId uuid NOT NULL,
	CONSTRAINT LinearAnchorPoint_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE PositioningSystemCoordinate (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	posSystemId uuid NOT NULL,
	CONSTRAINT PositioningSystemCoordinate_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE IntrinsicCoordinate (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	intrinsicCoord double precision NOT NULL,
	assocPosSystemId uuid NOT NULL,
	CONSTRAINT IntrinsicCoordinate_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearCoordinate (
	id uuid NOT NULL,
	lateralOffset double precision NOT NULL,
	measure double precision NOT NULL,
	verticalOffset double precision NOT NULL,
	linearPosSystemId uuid NOT NULL,
	CONSTRAINT LinearCoordinate_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE GeometricCoordinate (
	id uuid NOT NULL,
	x double precision NOT NULL,
	y double precision NOT NULL,
	z double precision,
	CONSTRAINT GeometricCoordinate_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE AssociatedPositioningSystem (
	id uuid NOT NULL,
	posSystemId uuid NOT NULL,
	posNetElemId uuid NOT NULL,
	CONSTRAINT AssociatedPositioningSystem_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE NetEntity (
	id uuid NOT NULL,
	CONSTRAINT NetEntity_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LocatedNetEntity (
	id uuid NOT NULL,
	CONSTRAINT LocatedNetEntity_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

--Implemented NetEntities

CREATE TABLE Switch (
	id uuid NOT NULL,
	turnType int,
	additionalProperties text,
	CONSTRAINT Switch_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE TABLE Track (
	id uuid NOT NULL,
	additionalProperties text,
	CONSTRAINT Track_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE TrackPoint (
	id uuid NOT NULL,
	index int,
	CONSTRAINT TrackPoint_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE Signal (
	id uuid NOT NULL,
	isNominalDirection boolean NOT NULL,
	type signal_type,
	additionalProperties text,
	CONSTRAINT Signal_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE Joint (
	id uuid NOT NULL,
	additionalProperties text,
	CONSTRAINT Joint_pk PRIMARY KEY (id)
) WITH (
	OIDS=FALSE
);

CREATE TABLE SignalReciever (
	id uuid NOT NULL,
	generatorId uuid NOT NULL,
	additionalProperties text,
	CONSTRAINT SignalReciever_pk PRIMARY KEY (id)
) WITH (
	OIDS=FALSE
);

CREATE TABLE SignalGenerator (
	id uuid NOT NULL,
	frequency int NOT NULL,
	type signal_generator_type,
	additionalProperties text,
	CONSTRAINT SignalGenerator_pk PRIMARY KEY (id)
) WITH (
	OIDS=FALSE
);


CREATE TABLE EntityLocation (
	id uuid NOT NULL,
	CONSTRAINT EntityLocation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE EntityLocations (
	netEntityId uuid NOT NULL,
	entityLocationId uuid NOT NULL,
	CONSTRAINT EntityLocations_pk PRIMARY KEY (netEntityId,entityLocationId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE SpotLocation (
	id uuid NOT NULL,
	applicationDirection applicationDirection NOT NULL,
	posNetElemId uuid,
	CONSTRAINT SpotLocation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE SpotLocationIntrinsic (
	id uuid NOT NULL,
	intrinsicCoord double precision NOT NULL,
	CONSTRAINT SpotLocationIntrinsic_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE SpotLocationCoordinate (
	id uuid NOT NULL,
	posSysCoordId uuid NOT NULL,
	CONSTRAINT SpotLocationCoordinate_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearLocation (
	id uuid NOT NULL,
	applicationDirection applicationDirection NOT NULL,
	CONSTRAINT LinearLocation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE GeometricPositioningSystem (
	id uuid NOT NULL,
	crsDefinition varchar NOT NULL,
	CONSTRAINT GeometricPositioningSystem_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearLocationNetElements (
	linearLocationId uuid NOT NULL,
	positioningNetElemId uuid NOT NULL,
	CONSTRAINT LinearLocationNetElements_pk PRIMARY KEY (linearLocationId,positioningNetElemId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE LinearLocationCoordinate (
	id uuid NOT NULL,
	CONSTRAINT LinearLocationCoordinate_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



--TODO: check multiply coordinates in the same posSystem.
CREATE TABLE LinearLocationStartCoordinates (
	posSystemCoordId uuid NOT NULL,
	linearLocationCoordId uuid NOT NULL,
	CONSTRAINT LinearLocationStartCoordinates_pk PRIMARY KEY (posSystemCoordId,linearLocationCoordId)
) WITH (
  OIDS=FALSE
);


--TODO: check multiply coordinates in the same posSystem.
CREATE TABLE LinearLocationEndCoordinates (
	posSystemCoordId uuid NOT NULL,
	linearLocationCoordId uuid NOT NULL,
	CONSTRAINT LinearLocationEndCoordinates_pk PRIMARY KEY (posSystemCoordId,linearLocationCoordId)
) WITH (
  OIDS=FALSE
);


CREATE TABLE AreaLocation (
	id uuid NOT NULL,
	CONSTRAINT AreaLocation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE IntrinsicCoordinates (
	intrinsicCoordId uuid NOT NULL,
	posSystemCoordId uuid NOT NULL,
	CONSTRAINT IntrinsicCoordinates_pk PRIMARY KEY (intrinsicCoordId,posSystemCoordId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE AssociatedNetElements (
	posNetElemId uuid NOT NULL,
	assocNetElemId uuid NOT NULL,
	CONSTRAINT AssociatedNetElements_pk PRIMARY KEY (posNetElemId,assocNetElemId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE NetElementsRelations (
	relationId uuid NOT NULL,
	netElementId uuid NOT NULL,
	CONSTRAINT NetElementsRelations_pk PRIMARY KEY (relationId,netElementId)
) WITH (
  OIDS=FALSE
);



CREATE TABLE PositionedElementsRelation (
	posRelationId uuid NOT NULL,
	posNetElemId uuid NOT NULL,
	CONSTRAINT PositionedElementsRelation_pk PRIMARY KEY (posRelationId,posNetElemId)
) WITH (
  OIDS=FALSE
);




ALTER TABLE Network ADD CONSTRAINT Network_fk0 FOREIGN KEY (id) REFERENCES BaseObject(id);

ALTER TABLE LevelNetwork ADD CONSTRAINT LevelNetwork_fk0 FOREIGN KEY (id) REFERENCES BaseObject(id);
ALTER TABLE LevelNetwork ADD CONSTRAINT LevelNetwork_fk1 FOREIGN KEY (networkId) REFERENCES Network(id);

ALTER TABLE NetworkResource ADD CONSTRAINT NetworkResource_fk0 FOREIGN KEY (id) REFERENCES BaseObject(id);
ALTER TABLE NetworkResource ADD CONSTRAINT NetworkResource_fk1 FOREIGN KEY (networkId) REFERENCES Network(id);

ALTER TABLE NetworkLevelResourses ADD CONSTRAINT NetworkLevelResourses_fk0 FOREIGN KEY (levelNetworkId) REFERENCES LevelNetwork(id);
ALTER TABLE NetworkLevelResourses ADD CONSTRAINT NetworkLevelResourses_fk1 FOREIGN KEY (networkResourceId) REFERENCES NetworkResource(id);

ALTER TABLE NetElement ADD CONSTRAINT NetElement_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);

ALTER TABLE CompositionNetElement ADD CONSTRAINT CompositionNetElement_fk0 FOREIGN KEY (id) REFERENCES NetElement(id);

ALTER TABLE PositionedRelation ADD CONSTRAINT PositionedRelation_fk0 FOREIGN KEY (id) REFERENCES Relation(id);

ALTER TABLE ElementPartCollection ADD CONSTRAINT ElementPartCollection_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);
ALTER TABLE ElementPartCollection ADD CONSTRAINT ElementPartCollection_fk1 FOREIGN KEY (compositionElemId) REFERENCES CompositionNetElement(id);

ALTER TABLE OrderedCollection ADD CONSTRAINT OrderedCollection_fk0 FOREIGN KEY (id) REFERENCES ElementPartCollection(id);

ALTER TABLE OrderedCollectionElements ADD CONSTRAINT OrderedCollectionElements_fk0 FOREIGN KEY (netElementId) REFERENCES NetElement(id);
ALTER TABLE OrderedCollectionElements ADD CONSTRAINT OrderedCollectionElements_fk1 FOREIGN KEY (orderedCollectionElementId) REFERENCES OrderedCollection(id);

ALTER TABLE UnorderedCollection ADD CONSTRAINT UnorderedCollection_fk0 FOREIGN KEY (id) REFERENCES ElementPartCollection(id);

ALTER TABLE UnoderedCollectionElements ADD CONSTRAINT UnoderedCollectionElements_fk0 FOREIGN KEY (netElementId) REFERENCES NetElement(id);
ALTER TABLE UnoderedCollectionElements ADD CONSTRAINT UnoderedCollectionElements_fk1 FOREIGN KEY (unorderedCollectionElementId) REFERENCES UnorderedCollection(id);

ALTER TABLE PositioningNetElement ADD CONSTRAINT PositioningNetElement_fk0 FOREIGN KEY (id) REFERENCES CompositionNetElement(id);

ALTER TABLE AssociatedNetElement ADD CONSTRAINT AssociatedNetElement_fk0 FOREIGN KEY (areaLocationId) REFERENCES AreaLocation(id);

ALTER TABLE LinearElement ADD CONSTRAINT LinearElement_fk0 FOREIGN KEY (id) REFERENCES PositioningNetElement(id);

ALTER TABLE SwitchPoint ADD CONSTRAINT SwitchPoint_fk0 FOREIGN KEY (id) REFERENCES NonLinearElement(id);

ALTER TABLE TrackPoint ADD CONSTRAINT TrackPoint_fk0 FOREIGN KEY (id) REFERENCES LocatedNetEntity(id);

ALTER TABLE TrackEdge ADD CONSTRAINT TrackEdge_fk0 FOREIGN KEY (id) REFERENCES LinearElement(id);

ALTER TABLE Bufferstop ADD CONSTRAINT Bufferstop_fk0 FOREIGN KEY (id) REFERENCES NonLinearElement(id);

ALTER TABLE Switch ADD CONSTRAINT Switch_fk0 FOREIGN KEY (id) REFERENCES LocatedNetEntity(id);

ALTER TABLE Track ADD CONSTRAINT Track_fk0 FOREIGN KEY (id) REFERENCES LocatedNetEntity(id);

ALTER TABLE Signal ADD CONSTRAINT Signal_fk0 FOREIGN KEY (id) REFERENCES TrackPoint(id);

ALTER TABLE Joint ADD CONSTRAINT Joint_fk0 FOREIGN KEY (id) REFERENCES TrackPoint(id);

ALTER TABLE SignalGenerator ADD CONSTRAINT SignalGenerator_fk0 FOREIGN KEY (id) REFERENCES TrackPoint(id);

ALTER TABLE SignalReceiver ADD CONSTRAINT SignalReceiver_fk0 FOREIGN KEY (id) REFERENCES TrackPoint(id);
ALTER TABLE SignalReceiver ADD CONSTRAINT SignalReceiver_fk1 FOREIGN KEY (generatorId) REFERENCES SignalGenerator(id);

ALTER TABLE NonLinearElement ADD CONSTRAINT NonLinearElement_fk0 FOREIGN KEY (id) REFERENCES PositioningNetElement(id);

ALTER TABLE Relation ADD CONSTRAINT Relation_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);

ALTER TABLE OrderedAssociatedNetElement ADD CONSTRAINT OrderedAssociatedNetElement_fk0 FOREIGN KEY (id) REFERENCES AssociatedNetElement(id);
ALTER TABLE OrderedAssociatedNetElement ADD CONSTRAINT OrderedAssociatedNetElement_fk1 FOREIGN KEY (linearLocationId) REFERENCES LinearLocation(id);

ALTER TABLE PositioningSystem ADD CONSTRAINT PositioningSystem_fk0 FOREIGN KEY (id) REFERENCES BaseObject(id);

ALTER TABLE PositioningSystemCoordinate ADD CONSTRAINT PositioningSystemCoordinate_fk0 FOREIGN KEY (posSystemId) REFERENCES PositioningSystem(id);

ALTER TABLE LinearPositioningSystem ADD CONSTRAINT LinearPositioningSystem_fk0 FOREIGN KEY (id) REFERENCES PositioningSystem(id);

ALTER TABLE LinearAnchorPoint ADD CONSTRAINT LinearAnchorPoint_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);
ALTER TABLE LinearAnchorPoint ADD CONSTRAINT LinearAnchorPoint_fk1 FOREIGN KEY (linearPoistioningSystemId) REFERENCES LinearPositioningSystem(id);


ALTER TABLE IntrinsicCoordinate ADD CONSTRAINT IntrinsicCoordinate_fk0 FOREIGN KEY (assocPosSystemId) REFERENCES AssociatedPositioningSystem(id);

ALTER TABLE LinearCoordinate ADD CONSTRAINT LinearCoordinate_fk0 FOREIGN KEY (id) REFERENCES PositioningSystemCoordinate(id);
ALTER TABLE LinearCoordinate ADD CONSTRAINT LinearCoordinate_fk1 FOREIGN KEY (linearPosSystemId) REFERENCES LinearPositioningSystem(id);

ALTER TABLE GeometricCoordinate ADD CONSTRAINT GeometricCoordinate_fk0 FOREIGN KEY (id) REFERENCES PositioningSystemCoordinate(id);

ALTER TABLE AssociatedPositioningSystem ADD CONSTRAINT AssociatedPositioningSystem_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);
ALTER TABLE AssociatedPositioningSystem ADD CONSTRAINT AssociatedPositioningSystem_fk1 FOREIGN KEY (posSystemId) REFERENCES PositioningSystem(id);
ALTER TABLE AssociatedPositioningSystem ADD CONSTRAINT AssociatedPositioningSystem_fk2 FOREIGN KEY (posNetElemId) REFERENCES PositioningNetElement(id);

ALTER TABLE NetEntity ADD CONSTRAINT NetEntity_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);

ALTER TABLE LocatedNetEntity ADD CONSTRAINT LocatedNetEntity_fk0 FOREIGN KEY (id) REFERENCES NetEntity(id);

ALTER TABLE EntityLocation ADD CONSTRAINT EntityLocation_fk0 FOREIGN KEY (id) REFERENCES NetworkResource(id);

ALTER TABLE EntityLocations ADD CONSTRAINT EntityLocations_fk0 FOREIGN KEY (netEntityId) REFERENCES LocatedNetEntity(id);
ALTER TABLE EntityLocations ADD CONSTRAINT EntityLocations_fk1 FOREIGN KEY (entityLocationId) REFERENCES EntityLocation(id);

ALTER TABLE SpotLocation ADD CONSTRAINT SpotLocation_fk0 FOREIGN KEY (id) REFERENCES EntityLocation(id);
ALTER TABLE SpotLocation ADD CONSTRAINT SpotLocation_fk1 FOREIGN KEY (posNetElemId) REFERENCES PositioningNetElement(id);

ALTER TABLE SpotLocationIntrinsic ADD CONSTRAINT SpotLocationIntrinsic_fk0 FOREIGN KEY (id) REFERENCES SpotLocation(id);

ALTER TABLE SpotLocationCoordinate ADD CONSTRAINT SpotLocationCoordinate_fk0 FOREIGN KEY (id) REFERENCES SpotLocation(id);
ALTER TABLE SpotLocationCoordinate ADD CONSTRAINT SpotLocationCoordinate_fk1 FOREIGN KEY (posSysCoordId) REFERENCES PositioningSystemCoordinate(id);

ALTER TABLE LinearLocation ADD CONSTRAINT LinearLocation_fk0 FOREIGN KEY (id) REFERENCES EntityLocation(id);

ALTER TABLE GeometricPositioningSystem ADD CONSTRAINT GeometricPositioningSystem_fk0 FOREIGN KEY (id) REFERENCES PositioningSystem(id);

ALTER TABLE LinearLocationNetElements ADD CONSTRAINT LinearLocationNetElements_fk0 FOREIGN KEY (linearLocationId) REFERENCES LinearLocation(id);
ALTER TABLE LinearLocationNetElements ADD CONSTRAINT LinearLocationNetElements_fk1 FOREIGN KEY (positioningNetElemId) REFERENCES PositioningNetElement(id);

ALTER TABLE LinearLocationCoordinate ADD CONSTRAINT LinearLocationCoordinate_fk0 FOREIGN KEY (id) REFERENCES LinearLocation(id);

ALTER TABLE LinearLocationStartCoordinates ADD CONSTRAINT LinearLocationStartCoordinates_fk0 FOREIGN KEY (posSystemCoordId) REFERENCES PositioningSystemCoordinate(id);
ALTER TABLE LinearLocationStartCoordinates ADD CONSTRAINT LinearLocationStartCoordinates_fk1 FOREIGN KEY (linearLocationCoordId) REFERENCES LinearLocationCoordinate(id);

ALTER TABLE LinearLocationEndCoordinates ADD CONSTRAINT LinearLocationEndCoordinates_fk0 FOREIGN KEY (posSystemCoordId) REFERENCES PositioningSystemCoordinate(id);
ALTER TABLE LinearLocationEndCoordinates ADD CONSTRAINT LinearLocationEndCoordinates_fk1 FOREIGN KEY (linearLocationCoordId) REFERENCES LinearLocationCoordinate(id);


ALTER TABLE AreaLocation ADD CONSTRAINT AreaLocation_fk0 FOREIGN KEY (id) REFERENCES EntityLocation(id);

--ALTER TABLE Circuit ADD CONSTRAINT Circuit_fk0 FOREIGN KEY (id) REFERENCES LocatedNetEntity(id);

ALTER TABLE IntrinsicCoordinates ADD CONSTRAINT IntrinsicCoordinates_fk0 FOREIGN KEY (intrinsicCoordId) REFERENCES IntrinsicCoordinate(id);
ALTER TABLE IntrinsicCoordinates ADD CONSTRAINT IntrinsicCoordinates_fk1 FOREIGN KEY (posSystemCoordId) REFERENCES PositioningSystemCoordinate(id);

ALTER TABLE AssociatedNetElements ADD CONSTRAINT AssociatedNetElements_fk0 FOREIGN KEY (posNetElemId) REFERENCES PositioningNetElement(id);
ALTER TABLE AssociatedNetElements ADD CONSTRAINT AssociatedNetElements_fk1 FOREIGN KEY (assocNetElemId) REFERENCES AssociatedNetElement(id);

ALTER TABLE NetElementsRelations ADD CONSTRAINT NetElementsRelations_fk0 FOREIGN KEY (relationId) REFERENCES Relation(id);
ALTER TABLE NetElementsRelations ADD CONSTRAINT NetElementsRelations_fk1 FOREIGN KEY (netElementId) REFERENCES NetElement(id);

ALTER TABLE PositionedElementsRelation ADD CONSTRAINT PositionedElementsRelation_fk0 FOREIGN KEY (posRelationId) REFERENCES PositionedRelation(id);
ALTER TABLE PositionedElementsRelation ADD CONSTRAINT PositionedElementsRelation_fk1 FOREIGN KEY (posNetElemId) REFERENCES PositioningNetElement(id);

ALTER TABLE BaseObject ADD CONSTRAINT BaseObjectDateCheck CHECK (validFrom <= validTo);

ALTER TABLE GeometricCoordinate ADD CONSTRAINT "unique_coords" UNIQUE(x, y, z);

CREATE UNIQUE INDEX "NULLzCoord" ON GeometricCoordinate(x, y) WHERE z IS NULL; 

-- ____           _____ ______   _____        _____ _  __          _____ ______  
--|  _ \   /\    / ____|  ____| |  __ \ /\   / ____| |/ /    /\   / ____|  ____| 
--| |_) | /  \  | (___ | |__    | |__) /  \ | |    | ' /    /  \ | |  __| |__    
--|  _ < / /\ \  \___ \|  __|   |  ___/ /\ \| |    |  <    / /\ \| | |_ |  __|   
--| |_) / ____ \ ____) | |____  | |  / ____ \ |____| . \  / ____ \ |__| | |____  
--|____/_/    \_\_____/|______| |_| /_/    \_\_____|_|\_\/_/    \_\_____|______| 
                                                                                
                                                                                


--ADD

CREATE OR REPLACE FUNCTION addBaseObject(name varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT uuid_generate_v4() INTO id;
			INSERT INTO BaseObject(id, name, validFrom, validTo) VALUES (id, $1, $2, $3);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addNetwork(name varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addBaseObject($1, $2, $3) INTO id;
			INSERT INTO Network(id) VALUES (id);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addLevelNetwork(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			nwid uuid;
		BEGIN
			SELECT id 
			FROM Network n JOIN BaseObject bo ON n.id = bo.id
			WHERE bo.name = $2
			INTO nwid; 

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Network not found';
			END IF;

			SELECT addBaseObject($1, $3, $4) INTO id;
			INSERT INTO LevelNetwork(id, networkId) VALUES (id, nwid);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addNetworkResource(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			nwid uuid;
		BEGIN
			SELECT n.id 
			FROM Network n JOIN BaseObject bo ON n.id = bo.id
			WHERE bo.name = $2
			INTO nwid; 

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Network not found';
			END IF;

			SELECT addBaseObject($1, $3, $4) INTO id;
			INSERT INTO NetworkResource(id, networkId) VALUES (id, nwid);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION setNetworkResourceLevel(networkLevelName varchar(100), networkResourceName varchar(100)) RETURNS void
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			nwlid uuid;
			nwrid uuid;
		BEGIN
			SELECT id 
			FROM LevelNetwork nl JOIN BaseObject bo ON nl.id = bo.id
			WHERE bo.name = $1
			INTO nwlid; 

			IF NOT FOUND THEN
				RAISE EXCEPTION 'LevelNetwork not found';
			END IF;
			
			SELECT id 
			FROM NetworkResource nr JOIN BaseObject bo ON nr.id = bo.id
			WHERE bo.name = $2
			INTO nwrid; 

			IF NOT FOUND THEN
				RAISE EXCEPTION 'NetworkResource not found';
			END IF;


			INSERT INTO NetworkLevelResources(levelNetworkId, networkResourceId) VALUES (nwlid, nwrid);
			RETURN;
		END;
	$$;


--DELETE

--CREATE OR REPLACE FUNCTION deleteBaseObject(name varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM BaseObject bo
			--WHERE bo.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'BaseObject not found';
			--END IF;
--
			--DELETE FROM BaseObject bo
			--WHERE bo.id = id;
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION deleteNetwork(name varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM Network n JOIN BaseObject bo ON n.id = bo.id
			--WHERE name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
			--DELETE FROM Network nw
			--WHERE nw.id = id;
			--RETURN id;
--
			--DELETE FROM BaseObject bo
			--WHERE bo.id = id;
			--RETURN id;
--
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION deleteNetworkResource(name varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM NetworkResource nwr
			--WHERE nwr.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'NetworkResource not found';
			--END IF;
		--	
			--DELETE FROM NetworkLevelResources nwlr
			--WHERE nwlr.nwrid = id;
			--RETURN id;
--
--
			--DELETE FROM NetworkResource nwr
			--WHERE nwr.id = id;
			--RETURN id;
--
			--DELETE FROM BaseObject bo
			--WHERE bo.id = id;
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION deleteLevelNetwork(name varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM LevelNetwork nwl
			--WHERE nwl.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'LevelNetwork not found';
			--END IF;
--
			--DELETE FROM NetworkLevelResources nwlr
			--WHERE nwlr.nwlid = id;
			--RETURN id;
--
			--DELETE FROM LevelNetwork nwl
			--WHERE nwl.id = id;
			--RETURN id;
--
			--DELETE FROM BaseObject bo
			--WHERE bo.id = id;
			--RETURN id;
		--END;
	--$$;

--UPDATE

--CREATE OR REPLACE FUNCTION updateBaseObject(oldName varchar(100), newName varchar(100), validFrom date, validTo date) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM BaseObject bo
			--WHERE bo.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'BaseObject not found';
			--END IF;
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validFrom= $3
			--WHERE bo.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $4
			--WHERE bo.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--
--CREATE OR REPLACE FUNCTION updateBaseObject(oldName varchar(100), newName varchar(100), validTo date) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM BaseObject bo
			--WHERE bo.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'BaseObject not found';
			--END IF;
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $3
			--WHERE bo.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateNetwork(oldName varchar(100), newName varchar(100), validFrom date, validTo date) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM Network nw
			--WHERE nw.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE Network nw
			--SET nw.name = $2
			--WHERE nw.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validFrom= $3
			--WHERE bo.id = id;
--
			--UPDATE Network nw
			--SET nw.validFrom= $3
			--WHERE nw.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $4
			--WHERE bo.id = id;
--
			--UPDATE Network nw
			--SET nw.validTo= $4
			--WHERE nw.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateNetwork(oldName varchar(100), newName varchar(100), validTo date) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
		--BEGIN
			--SELECT id
			--FROM Network nw
			--WHERE nw.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE Network nw
			--SET nw.name = $2
			--WHERE nw.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $3
			--WHERE bo.id = id;
--
			--UPDATE Network nw
			--SET nw.validTo= $3
			--WHERE nw.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateNetworkResource(oldName varchar(100), newName varchar(100), validFrom date, validTo date, networkName varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
			--nwid uuid;
		--BEGIN
			--SELECT id
			--FROM NetworkResource nwr
			--WHERE nwr.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'NetworkResource not found';
			--END IF;
--
			--SELECT id
			--FROM Network nw
			--WHERE nw.name = $5
			--INTO nwid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE NetworkResource nwr
			--SET nwr.name = $2
			--WHERE nwr.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validFrom= $3
			--WHERE bo.id = id;
--
			--UPDATE NetworkResource nwr
			--SET nwr.validFrom= $3
			--WHERE nwr.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $4
			--WHERE bo.id = id;
--
			--UPDATE NetworkResource nwr
			--SET nwr.validTo= $4
			--WHERE nwr.id = id;
--
--
			--UPDATE NetworkResource nwr
			--SET nwr.networkId = nwid
			--WHERE nwr.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateNetworkResource(oldName varchar(100), newName varchar(100), validTo date, networkName varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
			--nwid uuid;
		--BEGIN
			--SELECT id
			--FROM NetworkResource nwr
			--WHERE nwr.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'NetworkResource not found';
			--END IF;
--
			--SELECT id
			--FROM Network nw
			--WHERE nw.name = $4
			--INTO nwid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE NetworkResource nwr
			--SET nwr.name = $2
			--WHERE nwr.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $3
			--WHERE bo.id = id;
--
			--UPDATE NetworkResource nwr
			--SET nwr.validTo= $3
			--WHERE nwr.id = id;
--
--
			--UPDATE NetworkResource nwr
			--SET nwr.networkId = nwid
			--WHERE nwr.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateLevelNetwork(oldName varchar(100), newName varchar(100), validFrom date, validTo date, networkName varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
			--nwid uuid;
		--BEGIN
			--SELECT id
			--FROM LevelNetwork nwl
			--WHERE nwl.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'LevelNetwork not found';
			--END IF;
--
			--SELECT id
			--FROM Network nw
			--WHERE nw.name = $5
			--INTO nwid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE LevelNetwork nwl
			--SET nwl.name = $2
			--WHERE nwl.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validFrom= $3
			--WHERE bo.id = id;
--
			--UPDATE LevelNetwork nwl
			--SET nwl.validFrom= $3
			--WHERE nwl.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $4
			--WHERE bo.id = id;
--
			--UPDATE Network nwl
			--SET nwl.validTo= $4
			--WHERE nwr.id = id;
--
--
			--UPDATE LevelNetwork nwl
			--SET nwl.networkId = nwid
			--WHERE nwl.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateLevelNetwork(oldName varchar(100), newName varchar(100), validTo date, networkName varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--id uuid;
			--nwid uuid;
		--BEGIN
			--SELECT id
			--FROM LevelNetwork nwl
			--WHERE nwl.name = $1
			--INTO id;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'LevelNetwork not found';
			--END IF;
--
			--SELECT id
			--FROM Network nw
			--WHERE nw.name = $4
			--INTO nwid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Network not found';
			--END IF;
--
--
			--UPDATE BaseObject bo
			--SET bo.name = $2
			--WHERE bo.id = id;
--
			--UPDATE LevelNetwork nwl
			--SET nwl.name = $2
			--WHERE nwl.id = id;
--
			--UPDATE LevelNetwork nwl
			--SET nwl.validFrom= $3
			--WHERE nwl.id = id;
--
			--UPDATE BaseObject bo
			--SET bo.validTo= $3
			--WHERE bo.id = id;
--
			--UPDATE Network nwl
			--SET nwl.validTo= $3
			--WHERE nwr.id = id;
--
--
			--UPDATE LevelNetwork nwl
			--SET nwl.networkId = nwid
			--WHERE nwl.id = id;
--
			--RETURN id;
		--END;
	--$$;
--
--CREATE OR REPLACE FUNCTION updateNetworkResourceLevel(networkResourceName varchar(100), networkResourceLevelOldName varchar(100), networkResourceLevelNewName varchar(100)) RETURNS uuid
	--LANGUAGE plpgsql
	--AS $$
		--DECLARE 
			--nwrid uuid;
			--nwlid uuid;
			--nnwlid uuid;
		--BEGIN
			--SELECT id
			--FROM LevelNetwork nwl
			--WHERE nwl.name = $2
			--INTO nwlid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'Old LevelNetwork not found';
			--END IF;
--
			--SELECT id
			--FROM LevelNetwork nwl
			--WHERE nwl.name = $3
			--INTO nnwlid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'New LevelNetwork not found';
			--END IF;
--
--
			--SELECT id
			--FROM NetworkResource nwr
			--WHERE nwr.name = $1
			--INTO nwrid;
--
			--IF NOT FOUND THEN
				--RAISE EXCEPTION 'NetworkResource not found';
			--END IF;
--
--
			--UPDATE LevelNetworkResources
			--SET levelNetworkId = nnwlid
			--WHERE levelNetworkId = nwlid AND networkResourceId = nwrid;
--
			--RETURN id;
		--END;
	--$$;





--  _______ ____  _____   ____  _      ____   _______     __  _____        _____ _  __          _____ ______ 
-- |__   __/ __ \|  __ \ / __ \| |    / __ \ / ____\ \   / / |  __ \ /\   / ____| |/ /    /\   / ____|  ____|
--    | | | |  | | |__) | |  | | |   | |  | | |  __ \ \_/ /  | |__) /  \ | |    | ' /    /  \ | |  __| |__   
--    | | | |  | |  ___/| |  | | |   | |  | | | |_ | \   /   |  ___/ /\ \| |    |  <    / /\ \| | |_ |  __|  
--    | | | |__| | |    | |__| | |___| |__| | |__| |  | |    | |  / ____ \ |____| . \  / ____ \ |__| | |____ 
--    |_|  \____/|_|     \____/|______\____/ \_____|  |_|    |_| /_/    \_\_____|_|\_\/_/    \_\_____|______|
                                                                                                           
--ADD
--addNetElement
--addCompositionNetElement                                                                                                          
--addRelation
--createRelation
--addElementPartCollection
--addPositioningNetElement
--addPositionedRelation
--addLinearElement
--addNonLinearElement
--addTrackEdge
--addSwitchPoint



CREATE OR REPLACE FUNCTION addNetElement(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addNetworkResource($1, $2, $3, $4) INTO id;
			INSERT INTO NetElement(id) VALUES (id);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addCompositionNetElement(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addNetElement($1, $2, $3, $4) INTO id;
			INSERT INTO CompositionNetElement(id) VALUES (id);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addRelation(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addNetworkResource($1, $2, $3, $4) INTO id;
			INSERT INTO Relation(id) VALUES (id);

			RETURN id;
		END;
	$$;


CREATE OR REPLACE FUNCTION createRelation(relationName varchar(100), VARIADIC name varchar(100)[]) RETURNS void
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			rid uuid;
		BEGIN

			SELECT id
			FROM Relation r JOIN BaseObject bo ON bo.id = r.id
			WHERE name = relationName
			INTO rid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Relation not found';
			END IF;

			FOR i IN 1..array_upper($2, 1)
			LOOP
				SELECT id
				FROM NetElement
				WHERE name = $2[i]
				INTO id;

				IF NOT FOUND THEN
					RAISE EXCEPTION 'NetElement not found';
				END IF;
			
				INSERT INTO NetElementsRelations(relationId, netElementId) VALUES(rid, id);
			END LOOP;

			RETURN;
		END;
	$$;



CREATE OR REPLACE FUNCTION addElementPartCollection(name varchar(100), networkName varchar(100), validFrom date, validTo date, compositionElementName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			ceid uuid;
		BEGIN
			SELECT id
			FROM CompositionNetElement cne JOIN BaseObject bo ON bo.id = cne.id
			WHERE name = $5
			INTO ceid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'CompositionNetElement not found';
			END IF;

			SELECT addNetworkResource($1, $2, $3, $4) INTO id;
			INSERT INTO ElementPartCollection(id, compositionElementId) VALUES (id, ceid);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addPositioningNetElement(name varchar(100), networkName varchar(100), validFrom date, validTo date, posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			res uuid;
			psid uuid;
		BEGIN
			SELECT bo.id
			FROM PositioningSystem ps JOIN BaseObject bo ON bo.id = ps.id
			WHERE bo.name = posSystemName
			INTO psid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'PositioningSystem not found';
			END IF;

			
			SELECT addCompositionNetElement($1, $2, $3, $4) INTO res;
			INSERT INTO PositioningNetElement(id) VALUES (res);
			PERFORM addAssociatedPositioningSystem(NULL, $3, $4, $2, posSystemName, name);

			RETURN res;
		END;
	$$;

CREATE OR REPLACE FUNCTION addPositionedRelation(name varchar(100), networkName varchar(100), validFrom date, validTo date, nav navigability, posA usage, posB usage) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addRelation($1, $2, $3, $4) INTO id;
			INSERT INTO PositionedRelation(id, navigability, positionOnA, positionOnB) VALUES (id, $5, $6, $7);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION createPositionedRelation(elementA varchar(100), elementB varchar(100), networkName varchar(100), nav navigability, posA usage, posB usage) RETURNS void
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			rid uuid;
		BEGIN

			SELECT addPositionedRelation(elementA||'__'||elementB||'_relation', networkName, NULL, NULL, nav, posA, posB) INTO rid;

			SELECT pne.id
			FROM PositioningNetElement pne JOIN BaseObject bo ON bo.id = pne.id
			WHERE bo.name = $1
			INTO id;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'ElementA not found';
			END IF;
		
			INSERT INTO PositionedElementsRelation(posRelationId, posNetElemId) VALUES(rid, id);
			
			SELECT pne.id
			FROM PositioningNetElement pne JOIN BaseObject bo ON bo.id = pne.id
			WHERE bo.name = $2
			INTO id;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'ElementB not found';
			END IF;
		
			INSERT INTO PositionedElementsRelation(posRelationId, posNetElemId) VALUES(rid, id);

			RETURN;
		END;
	$$;

CREATE OR REPLACE FUNCTION addOrderedCollection(name varchar(100), networkName varchar(100), validFrom date, validTo date, compositionElementName varchar(100), seq int) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			ceid uuid;
		BEGIN
			SELECT id
			FROM CompositionNetElement cne JOIN BaseObject bo ON bo.id = cne.id
			WHERE name = $5
			INTO ceid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'CompositionNetElement not found';
			END IF;

			SELECT addElementPartCollection($1, $2, $3, $4, $5) INTO id;
			INSERT INTO OrderedCollection(id) VALUES (id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addUnorderedCollection(name varchar(100), networkName varchar(100), validFrom date, validTo date, compositionElementName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			ceid uuid;
		BEGIN
			SELECT id
			FROM CompositionNetElement cne JOIN BaseObject bo ON bo.id = cne.id
			WHERE name = $5
			INTO ceid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'CompositionNetElement not found';
			END IF;

			SELECT addElementPartCollection($1, $2, $3, $4, $5) INTO id;
			INSERT INTO UnorderedCollection(id) VALUES (id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addNetElementsToOrderedCollection(collectionName varchar(100), VARIADIC name varchar(100)[]) RETURNS void
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			cid uuid;
		BEGIN

			SELECT id
			FROM OrderedCollection oc JOIN BaseObject bo ON bo.id = oc.id
			WHERE name = collectionName
			INTO cid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Relation not found';
			END IF;

			FOR i IN 1..array_upper($2, 1)
			LOOP
				SELECT id
				FROM NetElement ne JOIN BaseObject bo ON bo.id = ne.id
				WHERE name = $2[i]
				INTO id;

				IF NOT FOUND THEN
					RAISE EXCEPTION 'NetElementNotFound';
				END IF;
			
				INSERT INTO OrderedCollectionElements(orderedCollectionElementId, netElementId) VALUES(cid, id);
			END LOOP;

			RETURN;
		END;
	$$;

CREATE OR REPLACE FUNCTION addNetElementsToUnorderedCollection(collectionName varchar(100), VARIADIC name varchar(100)[]) RETURNS void
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			cid uuid;
		BEGIN

			SELECT id
			FROM UnorderedCollection
			WHERE name = collectionName
			INTO cid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Relation not found';
			END IF;

			FOR i IN 1..array_upper($2, 1)
			LOOP
				SELECT id
				FROM NetElement ne JOIN BaseObject bo ON bo.id = ne.id
				WHERE name = $2[i]
				INTO id;

				IF NOT FOUND THEN
					RAISE EXCEPTION 'NetElementNotFound';
				END IF;
			
				INSERT INTO UnorderedCollectionElements(unorderedCollectionElementId, netElementId) VALUES(cid, id);
			END LOOP;

			RETURN;
		END;
	$$;

CREATE OR REPLACE FUNCTION addLinearElement(name varchar(100), networkName varchar(100), validFrom date, validTo date, posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addPositioningNetElement($1, $2, $3, $4, $5) INTO id;
			INSERT INTO LinearElement(id) VALUES (id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addTrackEdge(name varchar(100), validFrom date, validTo date, networkName varchar(100), posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addLinearElement($1, $4, $2, $3, $5) INTO id;
			INSERT INTO TrackEdge(id) VALUES (id);

			RETURN id;
		END;
	$$;


CREATE OR REPLACE FUNCTION addNonLinearElement(name varchar(100), networkName varchar(100), validFrom date, validTo date, posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addPositioningNetElement($1, $2, $3, $4, $5) INTO id;
			INSERT INTO NonLinearElement(id) VALUES (id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addSwitchPoint(name varchar(100), validFrom date, validTo date, networkName varchar(100), posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addNonLinearElement($1, $4, $2, $3, $5) INTO id;
			INSERT INTO SwitchPoint(id) VALUES (id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addTrackPoint(name varchar(100), validFrom date, validTo date, networkName varchar(100), posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addNonLinearElement($1, $4, $2, $3, $5) INTO id;
			INSERT INTO TrackPoint(id) VALUES (id);

			RETURN id;
		END;
	$$;





--  _____   ____   _____    _______     _______ _______ ______ __  __  _____   _____        _____ _  __          _____ ______ 
-- |  __ \ / __ \ / ____|  / ____\ \   / / ____|__   __|  ____|  \/  |/ ____| |  __ \ /\   / ____| |/ /    /\   / ____|  ____|
-- | |__) | |  | | (___   | (___  \ \_/ / (___    | |  | |__  | \  / | (___   | |__) /  \ | |    | ' /    /  \ | |  __| |__   
-- |  ___/| |  | |\___ \   \___ \  \   / \___ \   | |  |  __| | |\/| |\___ \  |  ___/ /\ \| |    |  <    / /\ \| | |_ |  __|  
-- | |    | |__| |____) |  ____) |  | |  ____) |  | |  | |____| |  | |____) | | |  / ____ \ |____| . \  / ____ \ |__| | |____ 
-- |_|     \____/|_____/  |_____/   |_| |_____/   |_|  |______|_|  |_|_____/  |_| /_/    \_\_____|_|\_\/_/    \_\_____|______|
                                                                                                                            
--ADD
--addPositioningSystem
--addGeometricPositioningSystem
--addPositioningSystemCoordinate
--addGeometricCoordinate
--addAssociatedPositioningSystem
                                                                                                                            
CREATE OR REPLACE FUNCTION addPositioningSystem(name varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addBaseObject($1, $2, $3) INTO id;
			INSERT INTO PositioningSystem(id) VALUES (id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addGeometricPositioningSystem(name varchar(100), validFrom date, validTo date, crsDefinition varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			SELECT addPositioningSystem($1, $2, $3) INTO id;
			INSERT INTO GeometricPositioningSystem(id, crsDefinition) VALUES (id, crsDefinition);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addPositioningSystemCoordinate(posSystemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			sid uuid;
			id uuid;
		BEGIN
			SELECT ps.id
			FROM PositioningSystem ps JOIN BaseObject bo ON ps.id = bo.id
			WHERE bo.name = posSystemName
			into sid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'unknown PositioningSystem';
			END IF;

			SELECT uuid_generate_v4() INTO id;
			INSERT INTO PositioningSystemCoordinate(posSystemId, id) VALUES (sid, id);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addGeometricCoordinate(posSystemName varchar(100), x double precision, y double precision, z double precision) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			id uuid;
			did uuid;
		BEGIN
			PERFORM gps.id
			FROM GeometricPositioningSystem gps JOIN BaseObject bo ON bo.id = gps.id
			WHERE bo.name = posSystemName;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'GeometricPositioningSystem not found';
			END IF;

			IF($4 IS NULL) THEN
				SELECT gc.id
				FROM GeometricCoordinate gc
				WHERE (gc.x = $2 AND gc.y = $3 AND gc.z IS NULL) 
				INTO did;
				
				IF FOUND THEN
					RETURN did;
				END IF;
			ELSE
				SELECT gc.id
				FROM GeometricCoordinate gc
				WHERE (gc.x = $2 AND gc.y = $3 AND gc.z = $4) 
				INTO did;

				IF FOUND THEN
					RETURN did;
				END IF;
			END IF;

			SELECT addPositioningSystemCoordinate($1) INTO id;
			INSERT INTO GeometricCoordinate(id, x, y, z) VALUES (id, x, y, z);

			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addAssociatedPositioningSystem(name varchar(100), validFrom date, validTo date, networkName varchar(100), posSystemName varchar(100), posNetElementName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	CALLED ON NULL INPUT
	AS $$
		DECLARE 
			apsid uuid;
			psid uuid;
			peid uuid;
		BEGIN
			SELECT bo.id
			FROM PositioningSystem ps JOIN BaseObject bo ON ps.id = bo.id
			WHERE bo.name = posSystemName
			INTO psid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'unknown PositioningSystem';
			END IF;


			SELECT pne.id
			FROM PositioningNetElement pne JOIN BaseObject bo ON pne.id = bo.id
			WHERE bo.name = posNetElementName
			INTO peid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'unknown PositioningElement';
			END IF;

			SELECT addNetworkResource($1, $4, $2, $3) INTO apsid;
			INSERT INTO AssociatedPositioningSystem(id, posSystemId, posNetElemId) VALUES (apsid, psid, peid);

			RETURN apsid;
		END;
	$$;




--  _   _ ______ _______   ______ _   _ _______ _____ _______ _____ ______  _____   _____        _____ _  __          _____ ______ 
-- | \ | |  ____|__   __| |  ____| \ | |__   __|_   _|__   __|_   _|  ____|/ ____| |  __ \ /\   / ____| |/ /    /\   / ____|  ____|
-- |  \| | |__     | |    | |__  |  \| |  | |    | |    | |    | | | |__  | (___   | |__) /  \ | |    | ' /    /  \ | |  __| |__   
-- | . ` |  __|    | |    |  __| | . ` |  | |    | |    | |    | | |  __|  \___ \  |  ___/ /\ \| |    |  <    / /\ \| | |_ |  __|  
-- | |\  | |____   | |    | |____| |\  |  | |   _| |_   | |   _| |_| |____ ____) | | |  / ____ \ |____| . \  / ____ \ |__| | |____ 
-- |_| \_|______|  |_|    |______|_| \_|  |_|  |_____|  |_|  |_____|______|_____/  |_| /_/    \_\_____|_|\_\/_/    \_\_____|______|
                                                                                                                                 
                                                                                                                                 
--ADD
--addNetEntity
--addLocatedNetEntity
--addEntityLocation
--addLinearLocation
--addLinearLocationCoordinate
--not impl:
--addSpotLocation
--addSpotLocationCoordinate
--addSpotLocationIntrinsic
--addAreaLocation
--addCircuit


CREATE OR REPLACE FUNCTION addNetEntity(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			nwid uuid;
		BEGIN
			SELECT addNetworkResource($1, $2, $3, $4) INTO id;
			INSERT INTO NetEntity(id) VALUES (id);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addLocatedNetEntity(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			nwid uuid;
		BEGIN
			SELECT addNetEntity($1, $2, $3, $4) INTO id;
			INSERT INTO LocatedNetEntity(id) VALUES (id);
			RETURN id;
		END;
	$$;
CREATE OR REPLACE FUNCTION addEntityLocation(name varchar(100), networkName varchar(100), validFrom date, validTo date) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			nwid uuid;
		BEGIN
			SELECT addNetworkResource($1, $2, $3, $4) INTO id;
			INSERT INTO EntityLocation(id) VALUES (id);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addLinearLocation(name varchar(100), networkName varchar(100), validFrom date, validTo date, aDir applicationDirection, VARIADIC linLocElements uuid[]) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			neid uuid;
		BEGIN
			SELECT addEntityLocation($1, $2, $3, $4) INTO id;
			INSERT INTO LinearLocation(id, applicationDirection) VALUES (id, $5);
			FOR i IN 1..array_upper($6, 1)
			LOOP
				--SELECT ne.id
				--FROM PositioningNetElement ne JOIN BaseObject bo ON bo.id = ne.id
				--WHERE bo.name = $6[i]
				--INTO neid;
--
				--IF NOT FOUND THEN
					--RAISE EXCEPTION 'PositioningNetElement not found ';
				--END IF;
			
				INSERT INTO LinearLocationNetElements(linearLocationId, positioningNetElemId) VALUES(id, $6[i]);
			END LOOP;

			RETURN id;
		END;
	$$;


CREATE OR REPLACE FUNCTION addLinearLocationCoordinate(name varchar(100), networkName varchar(100), validFrom date, validTo date, aDir applicationDirection, VARIADIC linLocElements uuid[]) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			nwid uuid;
		BEGIN
			SELECT addLinearLocation($1, $2, $3, $4, $5,VARIADIC $6) INTO id;
			INSERT INTO LinearLocationCoordinate(id) VALUES (id);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addSpotLocation(name varchar(100), networkName varchar(100), validFrom date, validTo date, aDir applicationDirection, netElemName varchar(100)) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
			pneid uuid;
			nwid uuid;
		BEGIN
			SELECT pne.id
			FROM PositioningNetElement pne JOIN BaseObject bo ON bo.id = pne.id
			WHERE bo.name = netElemName
			INTO pneid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'PositioningElement not found';
			END IF;

			SELECT addEntityLocation($1, $2, $3, $4) INTO id;
			INSERT INTO SpotLocation(id, applicationDirection, posNetElemId) VALUES (id, $5, pneid);
			RETURN id;
		END;
	$$;

CREATE OR REPLACE FUNCTION addSpotLocationCoordinate(name varchar(100), networkName varchar(100), validFrom date, validTo date, aDir applicationDirection, netElemName varchar(100), posSysCoordId uuid) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE 
			id uuid;
		BEGIN
			PERFORM pne.id
			FROM PositioningNetElement pne JOIN BaseObject bo ON bo.id = pne.id
			WHERE bo.name = netElemName;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'PositioningElement not found';
			END IF;

			SELECT addSpotLocation($1, $2, $3, $4, $5, $6) INTO id;
			INSERT INTO SpotLocationCoordinate(id, posSysCoordId ) VALUES (id, posSysCoordId);
			RETURN id;
		END;
	$$;


CREATE OR REPLACE FUNCTION addTrack(name varchar(100), networkName varchar(100), validFrom date, validTo date, locationName varchar(100), aDir applicationDirection, xStartCoord double precision, yStartCoord double precision, zStartCoord double precision, xEndCoord double precision, yEndCoord double precision, zEndCoord double precision, posSystemName varchar(100), addProps text) RETURNS uuid
	LANGUAGE plpgsql
----TODO: check that linear location coordinate system is associateded with positioning element 
	AS $$
		DECLARE 
			id uuid;
			leid uuid;
			llcid uuid;
			peid uuid;
			psid uuid;
			sgpscid uuid;
			egpscid uuid;
		BEGIN
			SELECT ps.id 
			FROM PositioningSystem ps JOIN BaseObject bo ON ps.id = bo.id
			WHERE bo.name = posSystemName
			INTO psid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'PositioningSystem not found';
			END IF;

			SELECT addTrackEdge($1||'_edge', $3, $4, $2, posSystemName) INTO peid;
			SELECT addGeometricCoordinate(posSystemName, xStartCoord, yStartCoord, zStartCoord) INTO sgpscid;
			SELECT addGeometricCoordinate(posSystemName, xEndCoord, yEndCoord, zEndCoord) INTO egpscid;
			SELECT addLocatedNetEntity($1, $2, $3, $4) INTO leid;
			SELECT addLinearLocationCoordinate($5, $2, $3, $4, $6, peid) INTO llcid;
			INSERT INTO LinearLocationStartCoordinates(posSystemCoordId, linearLocationCoordId) VALUES (sgpscid, llcid);
			INSERT INTO LinearLocationEndCoordinates(posSystemCoordId, linearLocationCoordId) VALUES (egpscid, llcid);
			INSERT INTO Track(id, additionalProperties) VALUES (leid, addProps);
			INSERT INTO EntityLocations(netEntityId, entityLocationId) VALUES (leid, llcid);
			RETURN leid;
		END;
	$$;



CREATE OR REPLACE FUNCTION addSwitch(name varchar(100), networkName varchar(100), validFrom date, validTo date, locationName varchar(100), appId applicationDirection, x double precision, y double precision, z double precision, posSystemName varchar(100), turnType int, addProps text) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE
			psid uuid;
			gpscid uuid;
			leid uuid;
			slcid uuid;
			spid uuid;
		BEGIN
			SELECT ps.id 
			FROM PositioningSystem ps JOIN BaseObject bo ON ps.id = bo.id
			WHERE bo.name = posSystemName
			INTO psid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'PositioningSystem not found';
			END IF;

			SELECT addSwitchPoint($1||'_point', $3, $4, $2, posSystemName) INTO spid;
			SELECT addGeometricCoordinate(posSystemName, x, y, z) INTO gpscid;
			SELECT addLocatedNetEntity($1, $2, $3, $4) INTO leid;
			SELECT addSpotLocationCoordinate($5, $2, $3, $4, appId, $1||'_point', gpscid) into slcid; 
			INSERT INTO EntityLocations(netEntityId, entityLocationId) VALUES (leid, slcid);

			INSERT INTO Switch(id, turnType, additionalProperties) VALUES (leid, turnType, addProps);

			RETURN leid;
		END;
	$$;


CREATE OR REPLACE FUNCTION addTrackPoint(name varchar(100), networkName varchar(100), validFrom date, validTo date, locationName varchar(100), appId applicationDirection, x double precision, y double precision, z double precision, posSystemName varchar(100), trackName varchar(100), index int) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE
			psid uuid;
			gpscid uuid;
			leid uuid;
			slcid uuid;
			tid uuid;
			pneid uuid;
			pnename varchar(100);
			slid uuid;
		BEGIN
			SELECT ps.id 
			FROM PositioningSystem ps JOIN BaseObject bo ON ps.id = bo.id
			WHERE bo.name = posSystemName
			INTO psid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'PositioningSystem not found';
			END IF;

			SELECT t.id 
			FROM Track t JOIN BaseObject bo ON t.id = bo.id
			WHERE bo.name = trackName
			INTO tid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Track not found';
			END IF;

			SELECT llne.positioningNetElemId
			FROM LinearLocationNetElements llne JOIN EntityLocations els ON els.entityLocationId = llne.linearLocationId
			WHERE els.netEntityId = tid
			INTO pneid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Associated with Track PositioningNetElement not found';
			END IF;


			SELECT bo.name
			FROM BaseObject bo
			WHERE bo.id = pneid
			INTO pnename;



			IF(z IS NULL) THEN
				SELECT sl.id
				FROM SpotLocationCoordinate sl JOIN GeometricCoordinate coord ON coord.id = sl.posSysCoordId
				WHERE coord.x = $7 AND coord.y = $8 AND coord.z IS NULL 
				INTO slid;

				IF FOUND THEN
					SELECT el.netEntityId
					FROM EntityLocations el JOIN SpotLocation sl ON el.entityLocationId = sl.id
					WHERE entityLocationId = slid AND sl.posNetElemId = pneid
					INTO leid;
		
					IF FOUND THEN
						RETURN lied;
					END IF;
				END IF;

			
			ELSE
				SELECT sl.id
				FROM SpotLocationCoordinate sl JOIN GeometricCoordinate coord ON coord.id = sl.posSysCoordId
				WHERE coord.x = $7 AND coord.y = $8 AND coord.z = $9
				INTO slid;

				IF FOUND THEN
					SELECT el.netEntityId
					FROM EntityLocations el JOIN SpotLocation sl ON el.entityLocationId = sl.id
					WHERE entityLocationId = slid AND sl.posNetElemId = pneid
					INTO leid;
		
					IF FOUND THEN
						RETURN lied;
					END IF;
				END IF;
			END IF;



			SELECT addGeometricCoordinate(posSystemName, x, y, z) INTO gpscid;
			SELECT addLocatedNetEntity($1, $2, $3, $4) INTO leid;
			SELECT addSpotLocationCoordinate($5, $2, $3, $4, $6, pnename, gpscid) into slcid; 
			INSERT INTO EntityLocations(netEntityId, entityLocationId) VALUES (leid, slcid);

			INSERT INTO TrackPoint(id, index) VALUES (leid, index);

			RETURN leid;
		END;
	$$;


CREATE OR REPLACE FUNCTION addSignal(pointId uuid, isNominalDirection boolean, type signal_type, additionalProperties text) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE
			sid uuid;
		BEGIN
			SELECT id
			FROM Signal
			WHERE id = pointId
			INTO sid;

			IF FOUND THEN 
				RAISE EXCEPTION 'This point not empty';
			END IF;

			INSERT INTO Signal(id, isNominalDirection, type, additionalProperties) VALUES (pointId, isNominalDirection, type, additionalProperties);

			RETURN pointId;
		END;
	$$;


CREATE OR REPLACE FUNCTION addJoint(pointId uuid, additionalProperties text) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE
			sid uuid;
		BEGIN
			SELECT id
			FROM Joint
			WHERE id = pointId
			INTO sid;

			IF FOUND THEN 
				RAISE EXCEPTION 'This point not empty';
			END IF;

			INSERT INTO Joint(id, additionalProperties) VALUES (pointId, additionalProperties);

			RETURN pointId;
		END;
	$$;

CREATE OR REPLACE FUNCTION addSignalGenerator(pointId uuid, type signal_generator_type, frequency int, additionalProperties text) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE
			sid uuid;
		BEGIN
			SELECT id
			FROM SignalGenerator
			WHERE id = pointId
			INTO sid;

			IF FOUND THEN 
				RAISE EXCEPTION 'This point not empty';
			END IF;

			INSERT INTO SignalGenerator(id, type, frequency, additionalProperties) VALUES (pointId, type, frequency, additionalProperties);

			RETURN pointId;
		END;
	$$;

CREATE OR REPLACE FUNCTION addSignalReceiver(pointId uuid, generatorId uuid, additionalProperties text) RETURNS uuid
	LANGUAGE plpgsql
	AS $$
		DECLARE
			sid uuid;
		BEGIN
			SELECT id
			FROM SignalReceiver
			WHERE id = pointId
			INTO sid;

			IF FOUND THEN 
				RAISE EXCEPTION 'This point not empty';
			END IF;

			INSERT INTO SignalReceiver(id, generatorId, additionalProperties) VALUES (pointId, generatorId, additionalProperties);

			RETURN pointId;
		END;
	$$;

CREATE OR REPLACE FUNCTION connectTracksToSwitch(switchName varchar(100), inTrackName varchar(100), outTrack1Name varchar(100), outTrack2Name varchar(100), networkName varchar(100)) RETURNS void
	LANGUAGE plpgsql
	AS $$
		DECLARE
			sid uuid;
			itid uuid;
			ot1id uuid;
			ot2id uuid;
			spid uuid;
			iteid uuid;
			ote1id uuid;
			ote2id uuid;
			slid uuid;
			itlid uuid;
			otl1id uuid;
			otl2id uuid;
			spneid uuid;
			itepneid uuid;


		BEGIN
			SELECT s.id 
			FROM Switch s JOIN BaseObject bo ON s.id = bo.id
			WHERE bo.name = switchName
			INTO sid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'Switch not found';
			END IF;

			SELECT t.id 
			FROM Track t JOIN BaseObject bo ON t.id = bo.id
			WHERE name = inTrackName
			INTO itid;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'InTrack not found';
			END IF;


			SELECT t.id 
			FROM Track t JOIN BaseObject bo ON t.id = bo.id
			WHERE name = outTrack1Name
			INTO ot1id;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'OutTrack1 not found';
			END IF;

			SELECT t.id 
			FROM Track t JOIN BaseObject bo ON t.id = bo.id
			WHERE name = outTrack2Name
			INTO ot2id;

			IF NOT FOUND THEN
				RAISE EXCEPTION 'OutTrack2 not found';
			END IF;

			SELECT s.id
			FROM Switch s JOIN BaseObject bo ON bo.id = s.id
			WHERE bo.name = switchName
			INTO spid;

			SELECT entityLocationId
			FROM EntityLocations
			WHERE netEntityId = spid
			INTO slid;

			SELECT posNetElemId
			FROM SpotLocation
			WHERE id = slid
			INTO spneid;

			SELECT s.id
			FROM Switch s JOIN BaseObject bo ON bo.id = s.id
			WHERE bo.name = switchName
			INTO spid;

			SELECT entityLocationId
			FROM EntityLocations
			WHERE netEntityId = spid
			INTO slid;

			SELECT posNetElemId
			FROM SpotLocation
			WHERE id = slid
			INTO itepneid;


			PERFORM createPositionedRelation(switchName||'_point', inTrackName||'_edge', networkName, 'Both', '0', '1');
			PERFORM createPositionedRelation(switchName||'_point', outTrack1Name||'_edge', networkName, 'Both', '1', '0');
			PERFORM createPositionedRelation(switchName||'_point', outTrack2Name||'_edge', networkName, 'Both', '1', '0');

			RETURN;
		END;
	$$;

