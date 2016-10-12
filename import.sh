neo4j-import     --into $NEO4J_HOME/data/databases/snomed_1.db \
                 --id-type integer \
                 --nodes /Users/shaun.walters/Documents/gdb/snomed_nodes.csv  \
                 --relationships /Users/shaun.walters/Documents/gdb/snomed_edges.csv \
                 --stacktrace \
                 --bad-tolerance 10000000
