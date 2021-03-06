#!/bin/bash 

source ../source/shell.sh

bucardo add db wallabydb_spsrc dbname=wallabydb user=bucardo port=18020
bucardo add db wallabydb_aussrc dbname=wallabydb user=bucardo host=146.118.67.204
bucardo add db wallabydb_cirada dbname=wallabydb user=bucardo host=206.12.93.99

bucardo add relgroup aussrctables         \
                wallaby.comment           \
                wallaby.detection         \
                wallaby.instance          \
                wallaby.product           \
                wallaby.run               \
                wallaby.run_metadata      \
                wallaby.source            \
                wallaby.source_detection  \
                wallaby.tag               \
                wallaby.tag_detection     \
                wallaby.tag_source_detection

bucardo add relgroup ciradatables wallaby.kinematic_model

#bucardo add sequence wallaby.comment_id_seq  \
#                     wallaby.detection_id_seq  \
#                     wallaby.instance_id_seq  \
#                     wallaby.observation_id_seq  \
#                     wallaby.product_id_seq  \
#                     wallaby.run_id_seq  \
#                     wallaby.run_metadata_id_seq \
#                     wallaby.source_detection_id_seq \
#                     wallaby.source_id_seq \
#                     wallaby.tag_detection_id_seq \
#                     wallaby.tag_id_seq \
#                     wallaby.kinematic_model_id_seq \
#                     wallaby.tag_source_detection_id_seq \
#                     db=wallabydb_spsrc relgroup=seq_aussrc

#bucardo add sequence wallaby.kinematic_model_id_seq \
#                     db=wallabydb_spsrc relgroup=seq_cirada

bucardo add dbgroup dbs_aussrc wallabydb_aussrc:source wallabydb_spsrc:target
bucardo add dbgroup dbs_cirada wallabydb_cirada:source wallabydb_spsrc:target

bucardo add sync wallabydb_aus_dbsync relgroup=aussrctables dbgroup=dbs_aussrc onetimecopy=2
bucardo add sync wallabydb_cirada_dbsync relgroup=ciradatables dbgroup=dbs_cirada onetimecopy=2
#bucardo add sync wallabydb_sequences_aussrc relgroup=seq_aussrc dbgroup=dbs_aussrc
#bucardo add sync wallabydb_sequences_cirada relgroup=seq_cirada dbgroup=dbs_cirada
