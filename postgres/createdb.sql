/*
Create three SNOMED tables:
Concept - all concepts
Descriptions - description concepts and relationships to concepts
Relationship - relationships between concepts
*/


create table concept (
id bigint constraint ckey primary key,
effectiveTime integer,
active integer,
moduleID bigint,
definitionStatusId bigint
);

create table relationship (
id bigint constraint rkey primary key,
effectiveTime integer,
active integer,
moduleID bigint,
sourceId bigint,
destinationId bigint,
relationshipGroup integer,
typeId integer,
characteristicTypeId bigint,
modifierId bigint
);

create table description (
id bigint constraint dkey primary key,
effectiveTime integer,
active integer,
moduleId bigint,
conceptId bigint,
languageCode varchar(10),
typeId bigint,
term varchar(300),
caseSignificanceId bigint
);

copy concept from '/Users/shaun.walters/Documents/snomeddb/snomedct/Snapshot/Terminology/sct2_Concept_Snapshot_US1000124_20160901.tsv';
copy description from '/Users/shaun.walters/Documents/snomeddb/snomedct/Snapshot/Terminology/sct2_Description_Snapshot-en_US1000124_20160901.tsv';
copy relationship from '/Users/shaun.walters/Documents/snomeddb/snomedct/Snapshot/Terminology/sct2_Relationship_Snapshot_US1000124_20160901.tsv';
