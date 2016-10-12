with
nodes_from_concept as (

/*
Create table to extract nodes from the concept table in SNOMED.
Assign labels (loosely) to help notate Neo4j
*/

select concept.id,
       description.term,
       case
       when description.term like '%(body structure)%' then 'body structure'
       when description.term like '%(finding)%' then 'finding'
       when description.term like '%(geographic location)%' then 'geographic location'
       when description.term like '%(event)%' then 'event'
       when description.term like '%(observable entity)%' then 'observable entity'
       when description.term like '%(organism)%' then 'organism'
       when description.term like '%(product)%' then 'product'
       when description.term like '%(physical force)%' then 'physical force'
       when description.term like '%(physical object)%' then 'physical object'
       when description.term like '%(procedure)%' then 'procedure'
       when description.term like '%(qualifier value)%' then 'qualifier value'
       when description.term like '%(record artifact)%' then 'record artifact'
       when description.term like '%(situation)%' then 'situation'
       when description.term like '%(metadata)%' then 'metadata'
       when description.term like '%(social concept)%' then 'social concept'
       when description.term like '%(special concept)%' then 'special concept'
       when description.term like '%(specimen)%' then 'specimen'
       when description.term like '%(staging scale)%' then 'staging scale'
       when description.term like '%(substance)%' then 'substance'
       when description.term like '%(attribute)%' then 'attribute'
       when description.term like '%(disorder)%' then 'disorder'
       when description.term like '%(morphologic abnormality)%' then 'morphological abnormality'
       when description.term like '%(environment)%' then 'environment'
       when description.term like '%(cell)%' then 'cell'
       when description.term like '%(cell structure)%' then 'cell structure'
       else null
       end as concept_label
from concept
inner join description
on concept.id = description.conceptid
where typeid = 900000000000003001
and concept.active = 1
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
group by term
)

/*
Create final nodes table
*/

copy (
select * from nodes_from_concept
union
select * from map_desc_concept
) to '/Users/shaun.walters/Documents/gdb/postgres/nodes.csv' WITH DELIMITER ',' HEADER;

