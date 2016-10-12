with
rels_from_relationship as (

/*
Create a table to extract relationships from the relationship table
in SNOMED. Assign labels to (loosely) match SNOMED.
*/

select sourceid,
       destinationid,
       description.term as relationship
from relationship
inner join description
on relationship.typeid = description.conceptid
where description.typeid = 900000000000003001
and relationship.active = 1
and description.active = 1),

map_desc_concept as (

/*
Create table to map descriptions to an ID (concept construct) a term, and label
*/

select distinct
       min(id) as id, -- ids are unique to the concept set
       term,
       'description' as concept_label
from description
where active = 1
group by term),

rels_from_description as (

/*
Create a table to extract description relationships from
description table.
*/

select a.conceptid as sourceid,
       a.destinationid,
       description.term as relationship
from (
    select description.conceptid,
           map_desc_concept.id as destinationid,
           description.typeid
    from map_desc_concept
    inner join description
    on map_desc_concept.term = description.term
    ) a
left join description
on a.typeid = description.conceptid
)


copy (select * from rels_from_relationship
      union
      select * from rels_from_description)
to '/Users/shaun.walters/Documents/gdb/edges.csv' WITH DELIMITER(',') HEADER;
